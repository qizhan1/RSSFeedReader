//
//  FeedPostCell.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

NS_ASSUME_NONNULL_BEGIN

@interface FeedPostCell : UICollectionViewCell

#pragma mark - Public Properties

@property (class, nonatomic, assign, readonly) NSString* identifier;
@property (nonatomic, strong) Article* article;

@end

NS_ASSUME_NONNULL_END
