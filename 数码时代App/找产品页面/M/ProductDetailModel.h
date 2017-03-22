//
//  ProductDetailModel.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject

@property (nonatomic, assign) NSInteger hotNew;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *idxPic;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, copy) NSString *noPriceMsg;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *url;


@end
