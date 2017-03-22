//
//  MyTableViewCell.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "MyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyModel.h"
@implementation MyTableViewCell
-(void)dealloc
{
    [_image release];
    [_alable release];
    [_blable release];
    [_model release];
    [super dealloc];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.image];
        self.alable = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.alable];
        self.blable = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.blable];
        [_alable release];
        [_blable release];
        [_image release];
    [self addObserver:self forKeyPath:@"model" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"model"]) {
        self.alable.text = self.model.name;
        self.blable.text = [NSString stringWithFormat:@"%@ 张",self.model.photoCount];
        [self.image setImageWithURL:[NSURL URLWithString:self.model.cover]];
    }
}
#pragma _
#pragma mark 布局
-(void)layoutSubviews
{
    self.image.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height-50);
    self.alable.frame = CGRectMake(10,self.image.frame.size.height,self.image.frame.size.width - 50,50);
    [self.alable setFont:[UIFont systemFontOfSize:12.0]];
    self.blable.frame = CGRectMake(self.alable.frame.size.width , self.image.frame.size.height + 10,100,50);
    [self.blable setFont:[UIFont systemFontOfSize:10.0]];
    [self.blable setBackgroundColor:[UIColor whiteColor]];
    [super layoutSubviews];
}

@end
