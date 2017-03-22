//
//  LuanTanViewController.h
//  数码时代App
//
//  Created by dlios on 15-1-6.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class FourScrollModel;



@interface LuanTanViewController : UIViewController
@property(nonatomic,retain)FourScrollModel *model;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;

@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIButton *aButton;

-(void)getModelLunTan:(FourScrollModel*)model;
@end
