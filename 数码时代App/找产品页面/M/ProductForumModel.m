//
//  ProductForumModel.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductForumModel.h"

@implementation ProductForumModel

- (void)dealloc
{
    [_channel release];
    [_id release];
    [_image release];
    [_pubDate release];
    [_title release];
    [_url release];
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
