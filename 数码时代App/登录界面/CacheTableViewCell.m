//
//  CacheTableViewCell.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import "CacheTableViewCell.h"

@implementation CacheTableViewCell
- (void)dealloc
{
    [_imagePic release];
    [_labelDetail release];
    [_labelTitle release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imagePic = [[UIImageView alloc] init];
        [self.contentView addSubview:_imagePic];
        [_imagePic release];
        
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_labelTitle];
        [_labelTitle release];
        
        self.labelDetail = [[UILabel alloc] init];
        [self.contentView addSubview:_labelDetail];
        [_labelDetail release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imagePic.frame = CGRectMake(10, 0, self.frame.size.width / 8, self.frame.size.height);
    self.labelTitle.frame = CGRectMake(_imagePic.frame.size.width + 20, 5, self.frame.size.width / 4, self.frame.size.height - 5);
    self.labelDetail.frame = CGRectMake(_labelTitle.frame.size.width + _imagePic.frame.size.width + 120, 5, self.frame.size.width / 4, self.frame.size.height - 5);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
