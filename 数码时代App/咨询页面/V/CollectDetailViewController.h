//
//  CollectDetailViewController.h
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"

@interface CollectDetailViewController : UIViewController

//@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) FirstModel *model;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIButton *aButton;

@end
