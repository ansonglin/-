//
//  ProductListViewController.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) NSDictionary *recommond;
@property (nonatomic, retain) UITableView *listTableView;

@end
