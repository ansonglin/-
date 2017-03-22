//
//  ThreeModel.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ThreeModel.h"

@implementation ThreeModel
-(void)dealloc
{
    [_url release];
    [_thumb release];
    [super dealloc];
}
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
