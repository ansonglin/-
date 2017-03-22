//
//  ProductDetailTableViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductDetailTableViewCell.h"

@implementation ProductDetailTableViewCell

- (void)dealloc
{
    [_img release];
    [_config release];
    [_cpu release];
    [_size release];
    [_dimensions release];
    [_title release];
    [_price release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
        [_img release];

        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title release];

        self.price = [[UILabel alloc] init];
        _price.textColor = [UIColor redColor];
        [self.contentView addSubview:_price];
        [_price release];

        self.cpu = [[UILabel alloc] init];
        _cpu.textColor = [UIColor grayColor];
        _cpu.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_cpu];
        [_cpu release];

        self.config = [[UILabel alloc] init];
        _config.textColor = [UIColor grayColor];
        _config.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_config];
        [_config release];

        self.size = [[UILabel alloc] init];
        _size.textColor = [UIColor grayColor];
        _size.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_size];
        [_size release];

        self.dimensions = [[UILabel alloc] init];
        _dimensions.textColor = [UIColor grayColor];
        _dimensions.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dimensions];
        [_dimensions release];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.img.frame = CGRectMake(5, 5, self.frame.size.width / 3 -  10, self.frame.size.height - 10);

    self.title.frame = CGRectMake(self.frame.size.width / 3 + 5, 5, self.frame.size.width * 2 / 3 - 10, self.frame.size.height / 4);

    self.price.frame = CGRectMake(self.frame.size.width / 3 + 5, self.frame.size.height / 4 + 5, self.frame.size.width * 2 / 3 - 10, self.frame.size.height / 4);

    self.cpu.frame = CGRectMake(self.frame.size.width / 3 + 5, self.frame.size.height / 2 + 5, self.frame.size.width / 6, self.frame.size.height / 4 - 10);
    _cpu.font = [UIFont systemFontOfSize:12.0f];

    self.config.frame = CGRectMake(self.frame.size.width / 2 + 5, self.frame.size.height / 2 + 5, self.frame.size.width / 2 - 10, self.frame.size.height / 4 - 10);
    _config.font = [UIFont systemFontOfSize:12.0f];

    self.size.frame = CGRectMake(self.frame.size.width / 3 + 5, self.frame.size.height * 3 / 4 + 5, self.frame.size.width / 6, self.frame.size.height / 4 - 10);
    _size.font = [UIFont systemFontOfSize:12.0f];

    self.dimensions.frame = CGRectMake(self.frame.size.width / 2 + 5, self.frame.size.height * 3 / 4 + 5, self.frame.size.width / 2 - 10, self.frame.size.height / 4 - 10);
    _dimensions.font = [UIFont systemFontOfSize:12.0f];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
