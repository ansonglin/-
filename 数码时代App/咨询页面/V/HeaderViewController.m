//
//  HeaderViewController.m
//  新写项目
//
//  Created by 安松林的dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "HeaderViewController.h"
//#import "ShareSDK/ShareSDK.h"
#import "FirstModel.h"
#import "NewsDataBase.h"
#import "CollectViewController.h"
#import "ConnectModel.h"

@interface HeaderViewController ()<UIWebViewDelegate>

@end

@implementation HeaderViewController

@synthesize webView, alert;

- (void)dealloc
{
    [_urlDic release];
    [_button release];
    [_aButton release];
    [webView release];
    [alert release];
     webView = nil;
     alert = nil;
    
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebview];
    
    // Do any additional setup after loading the view.
   self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"《资讯" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)] autorelease];
    
//    [self createShare];
    [self createButton];
}

#pragma mark -
#pragma 当再次进入app时判断该内容是否收藏,如果收藏,改变收藏图标
- (void)viewWillAppear:(BOOL)animated
{
    if ([NewsDataBase selectNewsForTitle:_urlDic.title]) {
        [_aButton setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    }
}

- (void)createWebview
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:_urlDic.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
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

#pragma mark -
#pragma 提示错误网址
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [alterview show];
//    [alterview release];
//}

#pragma mark -
#pragma 添加收藏按钮
- (void)createButton
{
    self.aButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _aButton.frame = CGRectMake(self.view.frame.size.width - 50, 0, 45, 45);
    [_aButton setBackgroundImage:[UIImage imageNamed:@"收藏2.png"] forState:UIControlStateNormal];
    [_aButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_aButton];
}
- (void)buttonAction:(id)sender
{
    if ([NewsDataBase selectNewsForTitle:_urlDic.title]) {
        [_aButton setBackgroundImage:[UIImage imageNamed:@"收藏2.png"] forState:UIControlStateNormal];
        [NewsDataBase delegateNewsModel:_urlDic];
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"收藏取消" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert1 show];
        // 使alert定时消失
        [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timerFireMethod:) userInfo:alert1 repeats:YES];
        [alert1 release];
    } else {
        // 把数据存储在数据库中
        FirstModel *model = [FirstModel firstModelWithTitle:_urlDic.title url:_urlDic.url];
        NSString *str = [NewsDataBase insertIntNewsWithModel:model];
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert1 show];
        [_aButton setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
        // 使alert定时消失
        [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timerFireMethod:) userInfo:alert1 repeats:YES];
        [alert1 release];
    }
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert = NULL;
}



#pragma mark -
#pragma 添加返回键左按钮
- (void)backButton
{
    [_button removeFromSuperview];
    [_aButton removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//
//#pragma mark -
//#pragma 添加分享按钮
//- (void)createShare
//{
//    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
//    _button.frame = CGRectMake(self.view.frame.size.width *5 / 7 , 0, 45, 45);
//    [_button setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
//    [_button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:_button];
//}
//- (void)shareAction:(id)sender
//{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
//    
//    //构造分享内容
//    NSString *str = [NSString stringWithFormat:@"%@, %@", _urlDic.title, _urlDic.url];
//    id<ISSContent> publishContent = [ShareSDK content:str defaultContent:@"测试一下" image:[ShareSDK imageWithPath:imagePath] title:@"ShareSDK" url:@"http://www.mob.com"
// description:@"这是一条测试信息" mediaType:SSPublishContentMediaTypeNews];
//    //创建弹出菜单容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
//    
//    //弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"分享成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//                                    [alert1 show];
//                                    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timerFireMethod:) userInfo:alert1 repeats:YES];
//                                    [alert1 release];
//
//                                    
//                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败"));
//                                }
//                            }];
//}

- (void)AlertAction:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
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
