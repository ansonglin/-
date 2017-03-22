//
//  DeViewController.h
//  数码时代App
//
//  Created by dlios on 15-1-4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class FourModel;
@interface DeViewController : UIViewController
@property(nonatomic,retain)FourModel *model;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,assign)BOOL flag;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIAlertView *alert;


-(void)getFourModel:(FourModel*)model Array:(NSMutableArray*)array;

@end
