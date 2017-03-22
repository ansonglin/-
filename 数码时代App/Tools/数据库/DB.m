//
//  DB.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年 All rights reserved.
//

#import "DB.h"

#import <sqlite3.h>

static sqlite3 *dbPoint = nil;


@implementation DB

+ (sqlite3 *)openDB
{
    if (dbPoint) {
        return dbPoint;
    }
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array firstObject];
    path = [NSString stringWithFormat:@"%@/news.rdb", path];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        NSString *main = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"rdb"];
        [manager copyItemAtPath:main toPath:path error:nil];
    }
    sqlite3_open([path UTF8String], &dbPoint);
    NSLog(@"path = %@", path);
    return dbPoint;
}











@end
