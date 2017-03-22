//
//  ButtonViewController.h
//  数码时代App
//
//  Created by dlios on 15-1-7.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonViewController : UIViewController
@property(nonatomic,assign)NSInteger flag;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;


-(void)getButton:(NSInteger)ButtonFlag;
@end
