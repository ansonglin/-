//
//  FourTableScrollTableViewCell.m
//  数码时代App
//
//  Created by dlios on 15-1-6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "FourTableScrollTableViewCell.h"

@implementation FourTableScrollTableViewCell
-(void)dealloc
{
    [_imageDig release];
    [_alable release];
    [_blable release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.alable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.imageDig = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.imageDig];
        self.blable = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.alable setBackgroundColor:[UIColor whiteColor]];
        [self.blable setTextColor:[UIColor darkGrayColor]];
        self.alable.numberOfLines = 0;
        self.blable.numberOfLines = 0;
        self.alable.font = [UIFont systemFontOfSize:14];
        self.blable.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.alable];
        [self addSubview:self.blable];
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
    
    self.alable.frame = CGRectMake(10, 10,self.frame.size.width - 20, 20);
    self.imageDig.frame = CGRectMake(10, 40, self.frame.size.width -20, (self.frame.size.width -20) * 9 / 16);
   // 自适应高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName, nil];
    CGRect rect = [self.blable.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 20, 1000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:dic context:nil];
    CGFloat hight = rect.size.height;
    self.blable.frame = CGRectMake(10, _imageDig.frame.size.height + 50, self.frame.size.width - 20, hight);
}

@end
