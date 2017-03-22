//
//  ProductType5TableViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 14/12/30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ProductType5TableViewCell.h"

@implementation ProductType5TableViewCell

- (void)dealloc
{
    [_bigPic release];
    [_logo1 release];
    [_logo2 release];
    [_logo3 release];
    [_logo4 release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigPic = [[UIImageView alloc] init];
        _bigPic.backgroundColor = [UIColor whiteColor];
        _bigPic.alpha = 0.8;
        [self.contentView addSubview:_bigPic];
        [_bigPic release];

        self.logo1 = [[UIImageView alloc] init];
        _logo1.backgroundColor = [UIColor whiteColor];
        _logo1.alpha = 0.8;
//        _logo1.layer.shadowOffset = CGSizeMake(0, 4);
//        _logo1.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo1.layer.shadowOpacity = 0.8;
//        _logo1.layer.shadowRadius = 4;
        [self.contentView addSubview:_logo1];
        [_logo1 release];

        self.logo2 = [[UIImageView alloc] init];
        _logo2.backgroundColor = [UIColor whiteColor];
        _logo2.alpha = 0.8;
//        _logo2.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo2.layer.shadowOffset = CGSizeMake(4, 0);
//        _logo2.layer.shadowOpacity = 0.8;
//        _logo2.layer.shadowRadius = 4;
        [self.contentView addSubview:_logo2];
        [_logo2 release];

        self.logo3 = [[UIImageView alloc] init];
        _logo3.backgroundColor = [UIColor whiteColor];
        _logo3.alpha = 0.8;
//        _logo3.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo3.layer.shadowOffset = CGSizeMake(4, -4);
//        _logo3.layer.shadowOpacity = 0.8;
//        _logo3.layer.shadowRadius = 4;
        [self.contentView addSubview:_logo3];
        [_logo3 release];

        self.logo4 = [[UIImageView alloc] init];
        _logo4.backgroundColor = [UIColor whiteColor];
        _logo4.alpha = 0.8;
//        _logo4.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo4.layer.shadowOffset = CGSizeMake(-4, -4);
//        _logo4.layer.shadowOpacity = 0.8;
//        _logo4.layer.shadowRadius = 4;
        [self.contentView addSubview:_logo4];
        [_logo4 release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bigPic.frame = CGRectMake(self.frame.size.width / 4, 0, self.frame.size.width / 2, self.frame.size.height);
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    [_bigPic setImage:[UIImage imageNamed:@"superLaptop.png"]];
    self.logo1.frame = CGRectMake(0, 0, self.frame.size.width / 4, self.frame.size.height / 2);
    [_logo1 setImage:[UIImage imageNamed:@"huashuo.png"]];
    self.logo2.frame = CGRectMake(self.frame.size.width / 4 * 3, 0, self.frame.size.width / 4, self.frame.size.height / 2);
    [_logo2 setImage:[UIImage imageNamed:@"hp.jpg"]];
    self.logo3.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width / 4, self.frame.size.height / 2);
    [_logo3 setImage:[UIImage imageNamed:@"xps.png"]];
    self.logo4.frame = CGRectMake(self.frame.size.width / 4 * 3, self.frame.size.height / 2, self.frame.size.width / 4, self.frame.size.height / 2);
    [_logo4 setImage:[UIImage imageNamed:@"thinkpad.jpg"]];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
