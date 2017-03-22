//
//  ConnectModel.m
//  豆瓣App
//
//  Created by Dave Cai on 14/11/9.
//  Copyright (c) 2014年 蔡 俊炜. All rights reserved.
//

#import "ConnectModel.h"
#import "Reachability.h"
#import "SaveFile.h"
@implementation ConnectModel
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
#pragma 判断网络状况
+(BOOL)judgeConnectEnabled
{
    Reachability *reach = [Reachability reachabilityWithHostName:FirstUrl];
    NetworkStatus staus = [reach currentReachabilityStatus];
    //获得当前状态
    switch (staus) {
        case NotReachable:
        {
            return NO;
        }
            break;
        case ReachableViaWiFi:
        {
            return YES;
        }
        
        case ReachableViaWWAN:
        {
            
            return YES;
        }
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma 获取Get请求的网址
+(NSString *)urlWithUrl:(NSString *)urlStr paramters:(NSDictionary *)parameter
{
     NSString *str = @"";
    for (NSString *key in [parameter allKeys]) {
        if ([str length] == 0) {
            str = [NSString stringWithFormat:@"?%@=%@",key, [parameter objectForKey:key]];
        }else {
            str = [NSString stringWithFormat:@"%@&%@=%@", str, key, [parameter objectForKey:key]];
        }
            }
    urlStr = [NSString stringWithFormat:@"%@%@", urlStr, str];
    return urlStr;
}

#pragma mark -
#pragma 连接服务器
-(void)startWithUrl:(NSString *)UrlStr paramters:(NSDictionary *)paramters
{
    UrlStr = [ConnectModel urlWithUrl:UrlStr paramters:paramters];
    self.urlName = [NSString stringWithFormat:@"%@",UrlStr];
    UrlStr = [UrlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:UrlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //判断代理人是否实现这个方法
    //if ([self.delegate respondsToSelector:@selector(requirstFinishData:)]) {
     //   [self.delegate requirstFinishData:_data];
       self.finishBlock(_data);
        self.urlName = [self.urlName stringByReplacingOccurrencesOfString:@"/" withString:@""];
        [SaveFile writeFileWithName:_urlName data:_data];
   // }
    
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"error = %@", error);
}

#pragma mark -
#pragma 异步get方法
+(void)getConnectWith:(NSString *)urlStr paramaters:(NSDictionary *)paramaters block:(FinishedBlock)block
{
    //判断网络是否连接成功
    if ([ConnectModel judgeConnectEnabled] == YES) {
        ConnectModel *model = [[ConnectModel alloc]init];
        model.finishBlock = block;
        [model  startWithUrl:urlStr paramters:paramaters];
        
    } else {
        //读取本地， 获取网址和参数拼完整的接口
        NSString *name = [ConnectModel urlWithUrl:urlStr paramters:paramaters];
        name = [name stringByReplacingOccurrencesOfString:@"/" withString:@""];
      //  NSLog(@"%@", name);
        NSMutableData *data = [SaveFile readFileWithName:name];
        if (data) {
           // [delegate requirstFinishData:data];
            block(data);
        }
    }
}

@end
