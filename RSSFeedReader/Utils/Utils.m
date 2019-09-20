//
//  User+NSAttributedString.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/19/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "Utils.h"

#pragma mark - NSAttributedString Category

@implementation NSAttributedString (RSSFeedReader)

+ (NSDictionary*)mainTitleAttributes {
    NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Heavy" size:18],
                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: [NSShadow titleTextShadow],
                                      NSParagraphStyleAttributeName: [NSParagraphStyle justifiedParagraphStyle]};
    
    return titleAttributes;
}

+ (NSDictionary*)titleAttributes {
    NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Heavy" size:12],
                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: [NSShadow titleTextShadow],
                                      NSParagraphStyleAttributeName: [NSParagraphStyle justifiedParagraphStyle]};
    
    return titleAttributes;
}

+ (NSAttributedString *)attributedStringForMainTitleText:(NSString *)text {
    NSAttributedString *attributedStr = nil;
    
    if (text != nil) {
        attributedStr =  [[NSAttributedString alloc] initWithString:text attributes: [NSAttributedString mainTitleAttributes]];
    }
    
    return attributedStr;
}

+ (NSAttributedString *)attributedStringForTitleText:(NSString *)text {
    NSAttributedString *attributedStr = nil;
    
    if (text != nil) {
        attributedStr = [[NSAttributedString alloc] initWithString:text attributes:[NSAttributedString titleAttributes]];
    }
    
    return attributedStr;
}

+ (NSAttributedString *)attributedStringForDescription:(NSString *)text {
    NSDictionary *descriptionAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16],
                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                            NSBackgroundColorAttributeName: [UIColor clearColor],
                                            NSParagraphStyleAttributeName: [NSParagraphStyle justifiedParagraphStyle]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:descriptionAttributes];
}

@end

#pragma mark - NSParagraphStyle Category

@implementation NSParagraphStyle (RSSFeedReader)

+ (NSParagraphStyle *)justifiedParagraphStyle {
    NSMutableParagraphStyle *paragraphStlye = [[NSMutableParagraphStyle alloc] init];
    paragraphStlye.alignment = NSTextAlignmentJustified;
    return paragraphStlye;
}

@end

#pragma mark - NSShadow Category

@implementation NSShadow (RSSFeedReader)

+ (NSShadow *)titleTextShadow {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
    shadow.shadowOffset = CGSizeMake(0, 2);
    shadow.shadowBlurRadius = 3.0;
    
    return shadow;
}

+ (NSShadow *)descriptionTextShadow {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    shadow.shadowOffset = CGSizeMake(0, 1);
    shadow.shadowBlurRadius = 3.0;
    
    return shadow;
}
@end

#pragma mark - UIColor Category

@implementation UIColor (RSSFeedReader)

+ (UIColor *)cardViewBackgroundColor {
    return [UIColor colorWithRed:68.0/255.0 green:126.0/255.0 blue:199.0/255.0 alpha:1];
}

@end

#pragma mark - NSString Category

@implementation NSString (RSSFeedReader)

- (NSString *)trimWhiteSpace {
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ "];
    NSDate *date  = [dateFormatter dateFromString:self];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    return [dateFormatter stringFromDate:date];
}

@end

#pragma mark - UIImageView Category

@implementation UIImageView (RSSFeedReader)

- (void)downloadWithURL:(NSString *)urlString {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:spinner];
    spinner.center = self.center;
    [spinner startAnimating];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *imageTask
    = [[NSURLSession sharedSession] dataTaskWithURL:url
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [spinner stopAnimating];
                                          self.image = [UIImage imageWithData:data];
                                          [spinner hidesWhenStopped ];
                                      });
                                  }];
    [imageTask resume];
}

@end
