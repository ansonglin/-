//
//  ConnectModel.h
//  豆瓣App
//
//  Created by Dave Cai on 14/11/9.
//  Copyright (c) 2014年 蔡 俊炜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishedBlock)(NSMutableData *data);
#define FirstUrl @"http://www.baidu.com"
#define SecondUrl @"http://www.sina.com"
#define ThirdUrl @"http://www.zhihu.com"
#define DetailUrl @"http://agent1.pconline.com.cn:8941/photolib/iphone_cate_json.jsp"
#define DetailUrl1 @"http://www.pconline.com.cn/app/bbs/focus"
#define DetailUrl2 @"http://www.pconline.com.cn/app/nq/1405/intf5401.js"
#define DetailUrl3 @""
#define detail4 @""
@interface ConnectModel : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic, retain)NSMutableData *data;
@property(nonatomic, retain)NSString *urlName;
@property(nonatomic, copy)FinishedBlock finishBlock;
+(void)getConnectWith:(NSString *)urlStr paramaters:(NSDictionary *)paramaters block:(FinishedBlock)block;
+(BOOL)judgeConnectEnabled;
@end
