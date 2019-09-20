//
//  Article.h
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

NS_ASSUME_NONNULL_BEGIN

@interface Article : NSObject

@property (nonatomic) NSString *descript;
@property (nonatomic) NSString *pubDate;
@property (nonatomic) Media *media;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *link;
@property (nonatomic) BOOL isMain;

@end

NS_ASSUME_NONNULL_END
