//
//  FourScrollModel.m
//  数码时代App
//
//  Created by dlios on 15-1-6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FourScrollModel.h"

@implementation FourScrollModel
-(void)dealloc
{
    [_image release];
    [_message release];
    [_title release];
    [_uri release];
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
