//
//  CardView.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/19/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "CardView.h"

#import "Article.h"
#import "Utils.h"

#pragma mark - Constants

static CGFloat radius = 2;
static NSInteger shadowOffsetWidth = 0;
static NSInteger shadowOffsetHeight = 3;
static CGFloat shadowOpacity = 0.5;
static CGFloat kPadding = 4.f;

#pragma mark - PostCardView Interface

@interface CardView ()

#pragma mark - Private Properties

@property (strong, nonatomic) UITextView *descriptionTextView;

@end

@implementation CardView

#pragma mark - Init

-(id)initWithCoder:(NSCoder *)aDecoder{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        self.backgroundColor = UIColor.cardViewBackgroundColor;
        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.descriptionTextView = [[UITextView alloc] init];
        [self addSubview:self.descriptionTextView];
        self.descriptionTextView.scrollEnabled = NO;
        self.descriptionTextView.editable = NO;
        self.descriptionTextView.backgroundColor = [UIColor clearColor];
        self.descriptionTextView.textContainer.maximumNumberOfLines = 2;
        self.descriptionTextView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    return self;
}


#pragma mark - Overrided Methods

-(void)layoutSubviews{
    [self drawCardLayer];
    
    CGSize size = self.bounds.size;
    if (self.article.isMain) {
        // Main article layout
        self.imageView.frame = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ?
            CGRectMake(0, 0, size.width, size.height / 2) : CGRectMake(0, 0, size.width, size.height * 2 / 3);;
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(size.width - kPadding * 2, size.height / 4)];
        self.titleLabel.frame = CGRectMake(kPadding, self.imageView.bounds.size.height + kPadding, titleSize.width, titleSize.height);
        self.descriptionTextView.frame = CGRectMake(kPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + kPadding, size.width - kPadding * 2, size.height * (1.0/3.0) - kPadding * 2);
    } else {
        // Previous article layout
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height * 2 / 3);
        self.titleLabel.frame = CGRectMake(kPadding, self.imageView.bounds.size.height, size.width - kPadding * 2, size.height / 3);
    }
}

#pragma mark - Private Methods

- (void)downloadImage {
    if (!self.imageView.image) {
        [self.imageView downloadWithURL:self.article.media.urlStr];
    }
}

- (void)drawCardLayer {
    self.layer.cornerRadius = radius;
    UIBezierPath *shadowPath = [UIBezierPath
                                bezierPathWithRoundedRect: self.bounds
                                cornerRadius: radius];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(shadowOffsetWidth, shadowOffsetHeight);
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = 10.f;
}

#pragma mark - Setters

- (void)setArticle:(Article *)article {
    _article = article;
    if (_article.isMain) {
        self.titleLabel.attributedText = [NSAttributedString attributedStringForMainTitleText: article.title];
        NSString *descript = [NSString stringWithFormat:@"%@ - %@", [article.pubDate dateString], article.descript ];
        self.descriptionTextView.attributedText = [NSAttributedString attributedStringForDescription: descript];
    } else {
        self.titleLabel.attributedText = [NSAttributedString attributedStringForTitleText: article.title];
    }
    
    [self downloadImage];
    [self layoutIfNeeded];
}

@end
