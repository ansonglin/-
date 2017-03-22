//
//  TuShuangTableViewCell.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-17.
//  Copyright (c) 2015年  All rights reserved.
//

#import "TuShuangTableViewCell.h"

@implementation TuShuangTableViewCell

- (void)dealloc
{
    [_imageV release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(2, 2, self.contentView.frame.size.width - 4, self.contentView.frame.size.height - 4);
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
