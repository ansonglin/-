//
//  MainViewController.h
//  A段产品页面
//
//  Created by chaziyjs on 14/12/29.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *mainTable;
@property (nonatomic, retain) NSMutableArray *array;

@end
