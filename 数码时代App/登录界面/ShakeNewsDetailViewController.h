//
//  ShakeNewsDetailViewController.h
//  数码时代App
//
//  Created by chaziyjs on 15/1/12.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"

@interface ShakeNewsDetailViewController : UIViewController

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;
//@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) FirstModel *model;
//@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIButton *aButton;


@end
