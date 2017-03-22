//
//  ContactModel.h
//  UI_豆瓣重做
//
//  Created by chaziyjs on 14/12/20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ContactDelegate <NSObject>

- (void)contect:(NSData *)data;

@end

@interface ContactModel : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *urlName;
@property (nonatomic, assign) id<ContactDelegate> delegate;

+ (void)contactStartConnectUrl:(NSString *)str parmaters:(NSDictionary *)parmaters delegate:(id<ContactDelegate>)delegate;

@end
