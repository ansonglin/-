//
//  ProductDetailTableViewCell.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *img;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) UILabel *cpu;
@property (nonatomic, retain) UILabel *config;
@property (nonatomic, retain) UILabel *size;
@property (nonatomic, retain) UILabel *dimensions;

@end
