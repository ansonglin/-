//
//  FirstModel.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel

- (void)dealloc
{
    [_title release];
    [_url release];
    [super dealloc];
}
+ (instancetype)firstModelWithTitle:(NSString *)title url:(NSString *)url
{
    FirstModel *model = [[FirstModel alloc] initWithTitle:title url:url];
    return [model autorelease];
}

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)url
{
    self = [super init];
    if (self) {
        self.title = title;
        self.url = url;
    }
    return self;
}


@end
