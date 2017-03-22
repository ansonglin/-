//
//  FirstModel.h
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;

+ (instancetype)firstModelWithTitle:(NSString *)title url:(NSString *)url;

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)url;

@end
