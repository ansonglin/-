//
//  SaveFile.m
//  豆瓣App
//
//  Created by Dave Cai on 14/11/9.
//  Copyright (c) 2014年 蔡 俊炜. All rights reserved.
//

#import "SaveFile.h"

@implementation SaveFile
#pragma mark -
#pragma 根据名字获取路径，library
+ (NSString *)pathWithName:(NSString *)name
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
    path = [NSString stringWithFormat:@"%@/%@",path ,name];
    NSLog(@"%@", path);
    return path;
}


#pragma mark -
#pragma 判断文件是否存在
+ (BOOL)judgeFileExistWithName:(NSString *)name
{
    NSString *path = [SaveFile pathWithName:name];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:path]) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark -
#pragma 取文件
+ (NSMutableData *)readFileWithName:(NSString *)name
{
    if ([SaveFile judgeFileExistWithName:name] == YES) {
        NSString *path = [SaveFile pathWithName:name];
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
        return data;
    } else {
        return nil;
    }
    
}

#pragma mark -
#pragma 存文件
+ (BOOL)writeFileWithName:(NSString *)name data:(NSData *)data
{
    NSString *path = [SaveFile pathWithName:name];
    return [data writeToFile:path atomically:YES];
}



@end
