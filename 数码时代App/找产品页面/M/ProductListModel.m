//
//  ProductListModel.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductListModel.h"

@implementation ProductListModel

- (void)dealloc
{
    [_logo release];
    [_name release];
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
