//
//  TuPianViewController.h
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyModel;
@class ThreeModel;
@interface TuPianViewController : UIViewController
@property(nonatomic,retain)MyModel *model;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,retain)UIScrollView *scroll;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,retain)NSMutableData *data;
@property(nonatomic,retain)ThreeModel *threeModel;
@property(nonatomic,retain)UIImageView *image;
@property(nonatomic,retain)NSMutableArray *Digarr;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,retain)NSString *name;

-(void)getValue:(MyModel*)model NsArray:(NSMutableArray*)array flag:(BOOL)flag;
@end
