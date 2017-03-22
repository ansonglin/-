//
//  MyTableViewCell.h
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyModel;
@interface MyTableViewCell : UITableViewCell
@property(nonatomic,retain)MyModel *model;
@property(nonatomic,retain)UIImageView *image;
@property(nonatomic,retain)UILabel *alable;
@property(nonatomic,retain)UILabel *blable;

@end
