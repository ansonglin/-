//
//  ButtonViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-7.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ButtonViewController.h"
#import "ConnectModel.h"
#import "UIImageView+WebCache.h"

@interface ButtonViewController ()<UIWebViewDelegate>

@end

@implementation ButtonViewController

@synthesize webView, alert;

-(void)dealloc
{
    [webView release];
    [alert release];
    webView = nil;
    alert = nil;
    [super dealloc];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self creatImage];
    [self WebView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)WebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 113)];
    webView.delegate = self;
    [self.view addSubview:webView];
    if (_flag == 5) {
//        车展摄影
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51993256?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
        [webView setScalesPageToFit:YES];
    }
    if (_flag == 0) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51995224?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
        [webView setScalesPageToFit:YES];
    }else if (_flag == 1)
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51996645?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
        [webView setScalesPageToFit:YES];
    }else if (_flag == 2)
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51997604?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
    }else if(_flag == 4)
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51994565?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
    }else if (_flag == 3)
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/51996311?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"]];
        [webView loadRequest:request];
    }
    [webView release];
}
#pragma mark -
#pragma 添加加载视图
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([ConnectModel judgeConnectEnabled] == YES) {
        if (alert == nil) {
            self.alert = [[UIAlertView alloc] initWithTitle: nil message: @"正在读取网络数据" delegate: self cancelButtonTitle: nil otherButtonTitles: nil];
        }
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
        [alert addSubview:activityView];
        [activityView startAnimating];
        [alert show];
        [activityView release];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    //    [alert release];
}





-(void)getButton:(NSInteger)ButtonFlag
{
    self.flag = ButtonFlag;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
