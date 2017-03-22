//
//  NewsDataBase.h
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstModel.h"
#import "NewsModel.h"

@interface NewsDataBase : NSObject

+ (NSString *)insertIntNewsWithModel:(FirstModel *)model;
+ (NSMutableArray *)selectAllNews;
+ (void)delegateNewsModel:(FirstModel *)model;
+ (BOOL)selectNewsForTitle:(NSString *)title;


@end
