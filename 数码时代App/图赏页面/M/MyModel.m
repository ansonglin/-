//
//  MyModel.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "MyModel.h"

@implementation MyModel
-(void)dealloc
{
    [_url release];
    [_name release];
    [_id release];
    [_photoCount release];
    [_cover release];
    [_width release];
    [_height release];
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
