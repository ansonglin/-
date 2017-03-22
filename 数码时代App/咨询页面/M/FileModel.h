//
//  FileModel.h
//  项目
//
//  Created by 安松林的dlios on 14-12-27.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

// 存储数据到library文件夹中, data:存储的数据 fileName:文件名
+ (void)saveFile:(NSData *)data fileName:(NSString *)fileName;

// 获取library文件夹中名字为fileName的文件的内容
+ (NSData *)readFileName:(NSString *)fileName;



@end
