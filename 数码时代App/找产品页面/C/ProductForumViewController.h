//
//  ProductForumViewController.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/5.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductForumViewController : UIViewController

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, assign) NSInteger urlId;
@property (nonatomic, retain) NSArray *name;
@property (nonatomic, retain) UICollectionView *collect;

@end
