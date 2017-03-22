//
//  ProductCollectionViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        [self.contentView addSubview:_webView];
        [_webView release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.webView.frame = CGRectMake(0, 24, self.frame.size.width, self.frame.size.height - 150);
}

@end
