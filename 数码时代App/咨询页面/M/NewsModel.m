//
//  NewsModel.m
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年 All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (void)dealloc
{
    [_url release];
    [_image release];
    [_title release];
    [_pubDate release];
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return @"";
}




@end
