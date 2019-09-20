//
//  User+NSAttributedString.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/19/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (RSSFeedReader)
+ (NSDictionary*)mainTitleAttributes;
+ (NSDictionary*)titleAttributes;
+ (NSAttributedString *)attributedStringForMainTitleText:(NSString *)text;
+ (NSAttributedString *)attributedStringForTitleText:(NSString *)text;
+ (NSAttributedString *)attributedStringForDescription:(NSString *)text;
@end

@interface NSParagraphStyle (RSSFeedReader)
+ (NSParagraphStyle *)justifiedParagraphStyle;
@end

@interface NSShadow (RSSFeedReader)
+ (NSShadow *)titleTextShadow;
+ (NSShadow *)descriptionTextShadow;
@end

@interface UIColor (RSSFeedReader)
+ (UIColor *)cardViewBackgroundColor;
@end

@interface NSString (RSSFeedReader)
- (NSString *)trimWhiteSpace;
- (NSString *)dateString;
@end

@interface UIImageView (RSSFeedReader)
- (void)downloadWithURL:(NSString *)urlString;
@end


NS_ASSUME_NONNULL_END
