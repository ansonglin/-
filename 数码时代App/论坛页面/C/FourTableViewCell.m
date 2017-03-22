//
//  FourTableViewCell.m
//  数码时代App
//
//  Created by dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell
-(void)dealloc
{
    [_alable release];
    [_blable release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.alable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,self.frame.size.width, self.frame.size.height/2)];
        self.blable = [[UILabel alloc] initWithFrame:CGRectMake(10,self.frame.size.height/2 + 30, self.frame.size.width, self.frame.size.height/2)];
        [self.blable setFont:[UIFont systemFontOfSize:12.0f]];
        [self.contentView addSubview:_alable];
        [self.contentView addSubview:_blable];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
