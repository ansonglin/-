//
//  FourCollectionViewCell.m
//  数码时代App
//
//  Created by dlios on 15-1-6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FourCollectionViewCell.h"

@implementation FourCollectionViewCell
-(void)dealloc
{
    [_image release];
    [_alable release];
    [_blable release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.alable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.blable = [[UILabel alloc] initWithFrame:CGRectZero];
        [_blable setBackgroundColor:[UIColor blackColor]];
        [_blable setAlpha:0.3];
        [_alable setTextColor:[UIColor whiteColor]];
        [self addSubview:_image];
        [self.image addSubview:_blable];
        [self.image addSubview:_alable];
    }
    return self;
}
-(void)layoutSubviews
{
    self.image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.alable.frame = CGRectMake(0,self.image.frame.size.height - 30, self.frame.size.width, 30);
    self.blable.frame = CGRectMake(0,self.image.frame.size.height - 30, self.frame.size.width, 30);
    [super layoutSubviews];
}
@end
