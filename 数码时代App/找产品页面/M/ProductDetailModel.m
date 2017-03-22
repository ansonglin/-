//
//  ProductDetailModel.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

- (void)dealloc
{
    [_idxPic release];
    [_items release];
    [_noPriceMsg release];
    [_shortName release];
    [_url release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
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
