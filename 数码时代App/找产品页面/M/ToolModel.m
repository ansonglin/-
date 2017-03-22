//
//  ToolModel.m
//  UI_豆瓣重做
//
//  Created by chaziyjs on 14/12/20.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ToolModel.h"

@implementation ToolModel


+ (NSString *)liberayPathWithName:(NSString *)fileName
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    path = [NSString stringWithFormat:@"%@/%@", path, fileName];
    return path;
}
#pragma mark -
#pragma 判断文件是否存在
+ (BOOL)fileExists:(NSString *)fileName
{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *path = [ToolModel liberayPathWithName:fileName];
    return [file fileExistsAtPath:path];
}
#pragma mark -
#pragma 将网络数据存储在本地
+ (void)saveFile:(NSData *)data Filename:(NSString *)fileName
{
    NSString *path = [ToolModel liberayPathWithName:fileName];
    [data writeToFile:path atomically:YES];
}
#pragma mark -
#pragma 读取本地数据
+ (NSData *)readFile:(NSString *)fileName
{
    if ([ToolModel fileExists:fileName])
    {
        NSString *path = [ToolModel liberayPathWithName:fileName];
        NSData *data = [NSData dataWithContentsOfFile:path];
        return data;
    }
    return [NSData data];
}


@end
