//
//  NoImageTableViewCell.m
//  新写项目
//
//  Created by 安松林的dlios on 15-1-4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "NoImageTableViewCell.h"

@implementation NoImageTableViewCell

- (void)dealloc
{
    [_labelDiscuss release];
    [_labelTime release];
    [_labelTitle release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelTitle = [[UILabel alloc] init];
        [self.labelTitle setNumberOfLines:0];
        self.labelTitle.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:_labelTitle];
        [_labelTitle release];
        
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.font = [UIFont systemFontOfSize:15.0f];
        self.labelTime.textColor = [UIColor grayColor];
        [self.contentView addSubview:_labelTime];
        [_labelTime release];
        
        self.labelDiscuss = [[UILabel alloc] init];
        self.labelDiscuss.font = [UIFont systemFontOfSize:15.0f];
        [self.labelDiscuss setTextAlignment:NSTextAlignmentRight];
        self.labelDiscuss.textColor = [UIColor grayColor];
        [self.contentView addSubview:_labelDiscuss];
        [_labelDiscuss release];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.labelTitle.frame = CGRectMake(15 , 2, self.frame.size.width - 20, 50);
    
    self.labelTime.frame = CGRectMake(15, 55, 100, 17);
    
    self.labelDiscuss.frame = CGRectMake(self.frame.size.width / 3 + 110, 55, self.frame.size.width / 3 - 20, 17);
}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
