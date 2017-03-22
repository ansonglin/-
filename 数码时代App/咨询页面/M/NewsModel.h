//
//  NewsModel.h
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (nonatomic, retain) NSString *image;
@property (nonatomic, assign) NSInteger cmtCount;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger informationType;


@end

