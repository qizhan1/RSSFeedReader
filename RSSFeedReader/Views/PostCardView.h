//
//  CardCardView.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/19/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;

NS_ASSUME_NONNULL_BEGIN

@interface CardCardView : UIView

@property (nonatomic, strong) Article* article;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
