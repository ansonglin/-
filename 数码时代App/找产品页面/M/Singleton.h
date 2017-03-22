//
//  Singleton.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger urlid;
+ (instancetype)shareInstance;

@end
