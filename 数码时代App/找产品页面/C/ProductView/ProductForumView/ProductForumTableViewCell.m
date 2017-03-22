//
//  ProductForumTableViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductForumTableViewCell.h"

@implementation ProductForumTableViewCell

- (void)dealloc
{
    [_channel release];
    [_forumtitle release];
    [_date release];
    [_back release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.back = [[UIImageView alloc] init];
        [self.contentView addSubview:_back];
        [_back release];

        self.forumtitle = [[UILabel alloc] init];
        _forumtitle.font = [UIFont systemFontOfSize:20.0f];
        [_back addSubview:_forumtitle];
        [_forumtitle release];

        self.channel = [[UILabel alloc] init];
        _channel.textAlignment = NSTextAlignmentCenter;
        _channel.textColor = [UIColor grayColor];
        _channel.font = [UIFont systemFontOfSize:14.0f];
        _channel.backgroundColor = [UIColor orangeColor];
        [_back addSubview:_channel];
        [_channel release];

        self.date = [[UILabel alloc] init];
        _date.textColor = [UIColor grayColor];
        _date.font = [UIFont systemFontOfSize:12.0f];
        [_back addSubview:_date];
        [_date release];
    }
    return self;
}

- (void)layoutSubviews
{
    self.back.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_back setImage:[UIImage imageNamed:@"forumBack.png"]];
    self.forumtitle.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height / 2 - 10);
    self.date.frame = CGRectMake(5, self.frame.size.height * 3 / 4 - 5, 100 , self.frame.size.height / 4 - 10);
    self.channel.frame = CGRectMake(self.frame.size.width * 3 / 4 - 5, self.frame.size.height * 3 / 4 - 5, self.frame.size.width / 4 - 10, self.frame.size.height / 4 - 10);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
