//
//  SortModel.m
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import "SortModel.h"

@implementation SortModel
- (void)dealloc
{
    [_sortArray release];
    [_touTiaoArray release];
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sortArray = [NSMutableArray array];
        self.touTiaoArray = [NSMutableArray array];
    }
    return self;
}


@end
