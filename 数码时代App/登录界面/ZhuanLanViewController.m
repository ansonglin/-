//
//  ZhuanLanViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-10.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ZhuanLanViewController.h"

@interface ZhuanLanViewController ()
{
    UIWebView *WebView;
}
@end

@implementation ZhuanLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatView];
    [self creatButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,50, 50)];
    [WebView addSubview:button];
    [button addTarget:self action:@selector(Chang:) forControlEvents:UIControlEventTouchUpInside];
    [button release];
}
-(void)Chang:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)creatView
{
    WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width, self.view.frame.size.height-30)];
    [self.view addSubview: WebView];
    NSString *string = @"http://www1.pconline.com.cn/mobile/appzhuanlan/ces2015/?FromApp";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    [WebView loadRequest:request];
    [WebView setScalesPageToFit:YES];
    [WebView release];
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
