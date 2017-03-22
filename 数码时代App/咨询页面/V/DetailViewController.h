//
//  DetailViewController.h
//  项目
//
//  Created by 安松林的dlios on 14-12-30.
//  Copyright (c) 2014年 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"

@interface DetailViewController : UIViewController

@property (nonatomic, retain) FirstModel *model;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIButton *aButton;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;

@end
