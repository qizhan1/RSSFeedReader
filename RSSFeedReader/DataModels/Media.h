//
//  Media.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Media : NSObject

@property (nonatomic) NSString *urlStr;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *medium;
@property (nonatomic) NSNumber *width;
@property (nonatomic) NSNumber *height;

@end

NS_ASSUME_NONNULL_END
