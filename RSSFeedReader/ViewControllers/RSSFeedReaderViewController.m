//
//  ViewController.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "RSSFeedReaderViewController.h"

#import "Article.h"
#import "FeedPostCell.h"
#import "RSSParser.h"
#import "RSSFeedReaderLayout.h"
#import "WebPageViewController.h"

#pragma mark - Constants

static NSString *kRSSFeedULRString = @"https://www.personalcapital.com/blog/feed/?cat=3%2C891%2C890%2C68%2C284";
static NSString *kMainScreenTitle = @"Research & Insights";
static NSString *kFreshButtonImageName = @"refresh.png";

#pragma mark - RSSFeedReaderViewController Interface

@interface RSSFeedReaderViewController () <RSSParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - Private Property

@property (nonatomic, strong) RSSParser *parser;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) RSSFeedReaderLayout* layout;
@property (nonatomic, strong) NSArray<Article *> *articles;
@property (nonatomic, strong) UIButton *refershButton;

@end

@implementation RSSFeedReaderViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = kMainScreenTitle;
    [self setupParser];
    [self setupCollectionView];
    [self setupNavigationBar];
}

#pragma mark - Private Methods

- (void)tapOnRefershButton:(id)sender {
    self.refershButton.enabled = NO;
    [self.parser parse:kRSSFeedULRString];
}

- (void)setupNavigationBar {
    UIImage* image = [UIImage imageNamed:kFreshButtonImageName];
    CGRect frameimg = CGRectMake(0, 0, 10,10);
    
    self.refershButton = [[UIButton alloc] initWithFrame:frameimg];
    [self.refershButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.refershButton addTarget:self action:@selector(tapOnRefershButton:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.refershButton setShowsTouchWhenHighlighted:YES];
    self.refershButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.refershButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIBarButtonItem *refreshButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.refershButton];
    
    self.navigationItem.rightBarButtonItem = refreshButtonItem;
}

- (void)setupCollectionView {
    self.layout = [[RSSFeedReaderLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.layout];
    [self.collectionView registerClass:FeedPostCell.self
            forCellWithReuseIdentifier:FeedPostCell.identifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.collectionView];
}

- (void)setupParser {
    self.parser = [[RSSParser alloc] initWithDelegate:self];
    [self.parser parse:kRSSFeedULRString];
}

#pragma mark - RSSParserDelegate

- (void)didCompleteParse:(NSArray<Article *> *)articles {
    self.refershButton.enabled = YES;
    self.articles = articles;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return section == 0 ? (self.articles.count == 0 ? 0 : 1 ): self.articles.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FeedPostCell.identifier
                                                                   forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (self.articles.count > 0) {
            self.articles[0].isMain = YES;
            cell.article = self.articles[0];
        }
    } else {
        if (indexPath.item + 1 < self.articles.count) {
            cell.article = self.articles[indexPath.item + 1];
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WebPageViewController *controller = [[WebPageViewController alloc] init];
    Article *article = nil;
    
    if (indexPath.section == 0) {
        article = self.articles[0];
    } else {
        if (indexPath.item + 1 < self.articles.count) {
            article = self.articles[indexPath.item + 1];
        }
    }
    controller.title = article.title;
    controller.link = article.link;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
