//
//  NewsDataBase.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年 All rights reserved.
//

#import "NewsDataBase.h"
#import "DB.h"
#import "FirstModel.h"
#import "NewsModel.h"

@implementation NewsDataBase
#pragma mark -
#pragma 向数据库中添加内容
+ (NSString *)insertIntNewsWithModel:(FirstModel *)model
{
    sqlite3 *dbPoint = [DB openDB];
    NSString *str = [NSString stringWithFormat:@"insert into newsDB(title,url) values('%@','%@')", model.title, model.url];
    int result = sqlite3_exec(dbPoint, [str UTF8String], nil, nil, nil);
    NSString *string = @"";
    if (result == SQLITE_OK) {
        string = [NSString stringWithFormat:@"%@收藏成功", string];
    } else {
        string = [NSString stringWithFormat:@"%@已收藏", string];
    }
    return string;
}
#pragma mark -
#pragma 查询数据库中的内容
+ (NSMutableArray *)selectAllNews
{
    sqlite3 *dbPoint = [DB openDB];
    sqlite3_stmt *stmt = nil;
    NSString *str = @"select title,url from newsDB";
    NSMutableArray *array = [NSMutableArray array];
    int result = sqlite3_prepare_v2(dbPoint, [str UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(stmt, 0);
            const unsigned char *newUrl = sqlite3_column_text(stmt, 1);
            NSString *newsName = [NSString stringWithUTF8String:(const char *)name];
            NSString *newsUrl = [NSString stringWithUTF8String:(const char *)newUrl];
            FirstModel *model = [FirstModel firstModelWithTitle:newsName url:newsUrl];
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}
#pragma mark -
#pragma 根据title判断该内容数据库中是否已经收藏
+ (BOOL)selectNewsForTitle:(NSString *)title
{
    sqlite3 *dbPoint = [DB openDB];
    sqlite3_stmt *stmt = nil;
    NSString *str = [NSString stringWithFormat:@"select title from newsDB where title = '%@'", title];
    int result = sqlite3_prepare_v2(dbPoint, [str UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            sqlite3_finalize(stmt);
            return YES;
        } else {
            sqlite3_finalize(stmt);
            return NO;
        }
    } else {
        sqlite3_finalize(stmt);
        return NO;
    }
    
}




+ (void)delegateNewsModel:(FirstModel *)model
{
    sqlite3 *dbpoint = [DB openDB];
    NSString *str = [NSString stringWithFormat:@"delete from newsDB where title = '%@'", model.title];
    int dele = sqlite3_exec(dbpoint, [str UTF8String], nil, nil, nil);
    if (dele == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}








@end
