//
//  ProductForumWebViewController.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/6.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductForumWebViewController : UIViewController

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, copy) NSString *url;

@end
