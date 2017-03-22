//
//  WoViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-12.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "WoViewController.h"

@interface WoViewController ()

@end

@implementation WoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatImage];
    [self creatButton];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"关于我们";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatImage
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height - 64)];
//    [image setImage:[UIImage imageNamed:@"AboutUs.png"]];
    [self.view addSubview:image];
    [image release];
}
-(void)creatButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button addTarget:self action:@selector(Aacton:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"8.png"] forState:UIControlStateNormal];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = bar;
    [button release];
    [bar release];
}
-(void)Aacton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
