//
//  NewsCollectionViewCell.h
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+PullLoad.h"
#import "SortModel.h"
#import "FirstModel.h"

@protocol NewsCollectionViewCellDelegate <NSObject>

- (void)jionTheNext:(FirstModel *)model;

@end

@interface NewsCollectionViewCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate,PullDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableArray;

@property (nonatomic, assign) id<NewsCollectionViewCellDelegate>delegate;

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger newsNumber;
@property (nonatomic, retain) SortModel *numberModel;


@end
