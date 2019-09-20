//
//  FeedPostCell.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "FeedPostCell.h"

#import "Article.h"
#import "CardView.h"

#pragma mark - Constants

const CGFloat kPadding = 5.f;

#pragma mark - FeedPostCell Interface

@interface FeedPostCell ()

@property (nonatomic, strong) CardView *cardview;

@end

@implementation FeedPostCell

#pragma mark - Class Methods

static NSString*_identifier = nil;

+ (NSString *)identifier {
    if (_identifier == nil) {
        _identifier = @"FeedPostCellIdentifier";
    }
    
    return _identifier;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.cardview = [[CardView alloc] init];
        [self.contentView addSubview:self.cardview];
    }
    
    return self;
}

#pragma mark - Overried Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cardview.frame = CGRectInset(self.contentView.bounds, kPadding, kPadding);
}

-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.cardview.titleLabel.text = nil;
    self.cardview.imageView.image = nil;
}

#pragma mark - Setter Methods

- (void)setArticle:(Article *)article {
    _article = article;
    _cardview.article = article;
}

@end
