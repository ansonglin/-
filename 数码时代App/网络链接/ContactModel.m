//
//  ContactModel.m
//  UI_豆瓣重做
//
//  Created by chaziyjs on 14/12/20.
//  Copyright (c) 2014年 All rights reserved.
//

#import "ContactModel.h"
#import "ToolModel.h"
#import "Reachability.h"

@implementation ContactModel


- (void)dealloc
{
    [_data release];
    [_urlName release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableData data];
    }
    return self;
}

#pragma mark -
#pragma 网络判断
+ (BOOL)judgeConnected
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
        {
            return NO;
        }
            break;
        case ReachableViaWiFi:
        {
            return YES;
        }
            break;
        case ReachableViaWWAN:
        {
            return YES;
        }
            break;
        default:
            break;
    }
}


+ (void)contactStartConnectUrl:(NSString *)str parmaters:(NSDictionary *)parmaters delegate:(id<ContactDelegate>)delegate {

    BOOL result = [ContactModel judgeConnected];
    if (result) {
        ContactModel *con = [[ContactModel alloc] init];
        con.delegate = delegate;
        [con startConnectURL:str parmaters:parmaters];
        [con release];
    }
    else {
        //从本地获取数据
        //以网址为文件名, 名字中不得包含'/'字符
        NSString *name = [ContactModel urlWithStr:str parmaters:parmaters];
        NSData *data = [ToolModel readFile:name];
        //将数据回调到页面
        [delegate contect:data];
    }

}

#pragma mark -
#pragma 获取完整地文件名, 以网址作为文件名

+ (NSString *)urlWithStr:(NSString *)urlStr parmaters:(NSDictionary *)parmaters
{
    NSString *mystr = @"";
    for (NSString *key in parmaters) {
        if ([mystr length] == 0) {
            mystr = [NSString stringWithFormat:@"?%@=%@", key, [parmaters objectForKey:key]];
        }
        else {
            mystr = [NSString stringWithFormat:@"%@%@=%@&", mystr, key,[parmaters objectForKey:key]];
        }
    }
    urlStr = [NSString stringWithFormat:@"%@%@", urlStr, mystr];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    return urlStr;
}

- (void)startConnectURL:(NSString *)str parmaters:(NSDictionary *)parmaters {

    NSString *mystr = @"";
    for (NSString *key in parmaters) {
        if ([mystr length] == 0) {
            mystr = [NSString stringWithFormat:@"?%@=%@", key, [parmaters objectForKey:key]];
        }
        else {
            mystr = [NSString stringWithFormat:@"%@%@=%@&", mystr, key,[parmaters objectForKey:key]];
        }
    }
    str = [NSString stringWithFormat:@"%@%@", str, mystr];

    self.urlName = str;

    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //存储数据
    NSString *name = [ContactModel urlWithStr:self.urlName parmaters:nil];
    [ToolModel saveFile:_data Filename:name];
    [self.delegate contect:_data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}


@end
