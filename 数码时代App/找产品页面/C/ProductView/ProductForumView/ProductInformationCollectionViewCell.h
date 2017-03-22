//
//  ProductInformationCollectionViewCell.h
//  A段产品页面
//
//  Created by chaziyjs on 15/1/6.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolModel.h"
#import "ContactModel.h"

@protocol collectionDelegate <NSObject>

- (void)pageIntoUrl:(NSString *)url;

@end

@interface ProductInformationCollectionViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate, ContactDelegate>

@property (nonatomic, assign) id<collectionDelegate> viewdelegate;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *forumArray;

@end
