//
//  DB.h
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface DB : NSObject

+ (sqlite3 *)openDB;

@end
