//
//  DeViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "DeViewController.h"
#import "FourModel.h"
#import "ConnectModel.h"

@interface DeViewController ()<UIWebViewDelegate>

@end

@implementation DeViewController

@synthesize webView, alert;

-(void)dealloc
{
    [_model release];
    [_arr release];
    [webView release];
    [alert release];
    webView = nil;
    alert = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatView];
        // Do any additional setup after loading the view.
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.arr = [NSMutableArray array];
        
    }
    return self;
}
-(void)creatView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
    webView.delegate = self;
    [self.view addSubview: webView];
    NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/itbbs/topics/%@",self.model.topicId];
    NSString *string = [NSString stringWithFormat:@"%@?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18",str];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    [webView loadRequest:request];
    [webView setScalesPageToFit:YES];
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







-(void)getFourModel:(FourModel*)model Array:(NSMutableArray*)array
{
    
    self.model = model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
