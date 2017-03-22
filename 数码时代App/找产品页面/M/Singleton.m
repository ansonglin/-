//
//  Singleton.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "Singleton.h"

static Singleton *share = nil;

@implementation Singleton

- (void)dealloc
{
    [super dealloc];
}

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!share) {
            share = [[Singleton alloc] init];
        }
    });
    return share;
}


@end
