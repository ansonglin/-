//
//  FileModel.m
//  项目
//
//  Created by 安松林的dlios on 14-12-27.
//  Copyright (c) 2014年  All rights reserved.
//

#import "FileModel.h"

@implementation FileModel
#pragma mark -
#pragma 找文件路径
+ (NSString *)libraryPathWithName:(NSString *)fileName
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array firstObject];
    path = [NSString stringWithFormat:@"%@/%@", path, fileName];
    return path;
}
#pragma mark -
#pragma 判断文件是否存在
+ (BOOL)fileExists:(NSString *)fileName
{
    NSString *path = [FileModel libraryPathWithName:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:path];
}
#pragma mark -
#pragma 存储文件
+ (void)saveFile:(NSData *)data fileName:(NSString *)fileName
{
    NSString *path = [FileModel libraryPathWithName:fileName];
    [data writeToFile:path atomically:YES];
}
#pragma mark -
#pragma 读取文件
+ (NSData *)readFileName:(NSString *)fileName
{
    BOOL judge = [FileModel fileExists:fileName];
    if (judge) {
        NSString *path = [FileModel libraryPathWithName:fileName];
        NSData *data = [NSData dataWithContentsOfFile:path];
        return data;
    }
    return [NSData data];
}


@end
