//
//  ToolModel.h
//  UI_豆瓣重做
//
//  Created by chaziyjs on 14/12/20.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolModel : NSObject

+ (void)saveFile:(NSData *)data Filename:(NSString *)fileName;

+ (NSData *)readFile:(NSString *)fileName;


@end
