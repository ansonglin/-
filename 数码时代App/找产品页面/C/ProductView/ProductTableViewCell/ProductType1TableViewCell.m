//
//  ProductTableViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 14/12/30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ProductType1TableViewCell.h"

@implementation ProductType1TableViewCell

- (void)dealloc
{
    [_bigPic release];
    [_logo1 release];
//    [_logo2 release];
//    [_logo3 release];
//    [_logo4 release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.logo4 = [[UIImageView alloc] init];
//        _logo4.backgroundColor = [UIColor whiteColor];
//        _logo4.alpha = 0.8;
//        [self.contentView addSubview:_logo4];
//        [_logo4 release];

        self.logo1 = [[UIImageView alloc] init];
        _logo1.backgroundColor = [UIColor whiteColor];
        _logo1.alpha = 0.8;
        [self.contentView addSubview:_logo1];
        [_logo1 release];

//        self.logo3 = [[UIImageView alloc] init];
//        _logo3.backgroundColor = [UIColor whiteColor];
//        _logo3.alpha = 0.9;
//        _logo3.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo3.layer.shadowOffset = CGSizeMake(4, -4);
//        _logo3.layer.shadowOpacity = 0.9;
//        _logo3.layer.shadowRadius = 4;
//        [self.contentView addSubview:_logo3];
//        [_logo3 release];

//        self.logo2 = [[UIImageView alloc] init];
//        _logo2.backgroundColor = [UIColor whiteColor];
//        _logo2.alpha = 0.9;
//        _logo2.layer.shadowColor = [UIColor grayColor].CGColor;
//        _logo2.layer.shadowOffset = CGSizeMake(-4, 4);
//        _logo2.layer.shadowOpacity = 0.9;
//        _logo2.layer.shadowRadius = 4;
//        [self.contentView addSubview:_logo2];
//        [_logo2 release];

        self.bigPic = [[UIImageView alloc] init];
        _bigPic.backgroundColor = [UIColor whiteColor];
        _bigPic.alpha = 0.9;
        [self.contentView addSubview:_bigPic];
//        [_bigPic.layer setShadowColor:[UIColor grayColor].CGColor];
//        [_bigPic.layer setShadowOffset:CGSizeMake(4, 4)];
//        [_bigPic.layer setShadowOpacity:0.8];
//        [_bigPic.layer setShadowRadius:4];
        [_bigPic release];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    self.bigPic.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    [_bigPic setImage:[UIImage imageNamed:@"phone.png"]];
    self.logo1.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    [_logo1 setImage:[UIImage imageNamed:@"apple.png"]];
//    self.logo2.frame = CGRectMake(self.frame.size.width * 3 / 4 + 0, 0, self.frame.size.width / 4, self.frame.size.height / 2);
//    [_logo2 setImage:[UIImage imageNamed:@"mi.png"]];
//    self.logo3.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, self.frame.size.width / 4, self.frame.size.height / 2);
//    [_logo3 setImage:[UIImage imageNamed:@"meizuLogo.png"]];
//    self.logo4.frame = CGRectMake(self.frame.size.width * 3 / 4, self.frame.size.height / 2, self.frame.size.width / 4, self.frame.size.height / 2);
//    [_logo4 setImage:[UIImage imageNamed:@"samsungLogo.png"]];
}






- (void)awakeFromNib {
    // Initialization code
}





















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
