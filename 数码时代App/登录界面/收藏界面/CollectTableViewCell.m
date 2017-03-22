//
//  CollectTableViewCell.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import "CollectTableViewCell.h"

@implementation CollectTableViewCell
- (void)dealloc
{
    [_imagePic release];
    [_labelname release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imagePic = [[UIImageView alloc] init];
        [self.contentView addSubview:_imagePic];
        [_imagePic release];
        self.labelname = [[UILabel alloc] init];
        _labelname.font = [UIFont systemFontOfSize:14.0f];
        [_labelname setNumberOfLines:0];
        [_imagePic addSubview:_labelname];
        [_labelname release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imagePic.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.imagePic setImage:[UIImage imageNamed:@"CollectionCellBack.png"]];
    
    self.labelname.frame = CGRectMake(10, 5, _imagePic.frame.size.width - 10, _imagePic.frame.size.height - 5);
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
