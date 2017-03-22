//
//  ScrollViewController.h
//  数码时代App
//
//  Created by dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class FourModel;
@interface ScrollViewController : UIViewController
@property(nonatomic,retain)FourModel *model;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,retain)NSMutableData *data;
-(void)getScrollModel:(FourModel*)model;
@end
