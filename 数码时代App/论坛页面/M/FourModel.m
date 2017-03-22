//
//  FourModel.m
//  数码时代App
//
//  Created by dlios on 15-1-4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FourModel.h"

@implementation FourModel
-(void)dealloc
{
    [_image release];
    [_title release];
    [_topics release];
    [_forumName release];
    [_topicId release];
    [_forumId release];
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
