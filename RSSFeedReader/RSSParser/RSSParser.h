//
//  RSSParser.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@protocol RSSParserDelegate <NSObject>

- (void)didCompleteParse:(NSArray<Article *>*_Nullable) articles;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RSSParser : NSObject <NSXMLParserDelegate>

#pragma mark - Delegate

@property (nonatomic, weak) id<RSSParserDelegate> delegate;

#pragma mark - Public Methods

- (RSSParser*)initWithDelegate:(id<RSSParserDelegate>)delegate;
- (void)parse:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
