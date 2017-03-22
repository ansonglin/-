//
//  SharkNewsViewController.h
//  数码时代App
//
//  Created by chaziyjs on 15/1/10.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharkNewsViewController : UIViewController

@property (nonatomic, retain) UITableView *shakeTable;
@property (nonatomic, retain) UIImageView *shakeImage;
@property (nonatomic, retain) UIImageView *shakeBackPic;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) NSMutableArray *shakeArray;

@end
