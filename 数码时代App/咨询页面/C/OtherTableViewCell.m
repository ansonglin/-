//
//  OtherTableViewCell.m
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell
- (void)dealloc
{
    [_labelDiscuss release];
    [_labelImage release];
    [_labelTime release];
    [_labelTitle release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_labelImage];
        [_labelImage release];
        
        self.labelTitle = [[UILabel alloc] init];
        [self.labelTitle setNumberOfLines:0];
        [self.contentView addSubview:_labelTitle];
        [_labelTitle setFont:[UIFont systemFontOfSize:16.0f]];
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
    self.labelImage.frame = CGRectMake(5, 5, self.frame.size.width / 3, self.frame.size.width / 3 * 0.5628);
    
    self.labelTitle.frame = CGRectMake(self.frame.size.width / 3 + 10, 2, self.frame.size.width - _labelImage.frame.size.width - 10, 43);
    
    self.labelTime.frame = CGRectMake(self.frame.size.width / 3 + 10, 55, 100, 17);
    
    self.labelDiscuss.frame = CGRectMake(self.frame.size.width / 3 + 130, 55, self.frame.size.width - _labelTime.frame.size.width - _labelImage.frame.size.width - 35, 17);
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
