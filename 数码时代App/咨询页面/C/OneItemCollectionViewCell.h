//
//  OneItemCollectionViewCell.h
//  新写项目
//
//  Created by 安松林的dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+PullLoad.h"
#import "FirstModel.h"

@protocol OneItemCollectionViewCellDelegate <NSObject>
// 代理方法进入详情
- (void)jionHeaderDetail:(FirstModel *)dic;
- (void)jionNewsDetail:(FirstModel *)model;

@end

@interface OneItemCollectionViewCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate,PullDelegate>

@property (nonatomic, retain) NSMutableArray *itemArray;
@property (nonatomic, retain) NSMutableArray *headerArray;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, assign) id<OneItemCollectionViewCellDelegate>delegate;

@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UIScrollView *scrollheader;


@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger number;



- (void)downLoadEnd;



@end
