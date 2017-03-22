//
//  NewsCollectionViewCell.m
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "UIScrollView+PullLoad.h"
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NoImageTableViewCell.h"
#import "OtherTableViewCell.h"
#import "ConnectModel.h"
#import "SortModel.h"
#import "NewsModel.h"

@implementation NewsCollectionViewCell
- (void)dealloc
{
    [_numberModel release];
    [_tableArray release];
    [_tableView release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height - 20) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.pullDelegate = self;
        _tableView.canPullDown = YES;
        _tableView.canPullUp = YES;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerClass:[OtherTableViewCell class] forCellReuseIdentifier:@"cell2"];
        [self.tableView registerClass:[NoImageTableViewCell class] forCellReuseIdentifier:@"cell3"];
        [self.contentView addSubview:self.tableView];
        [self.tableView release];
      
        self.tableArray = [NSMutableArray array];
        
        _number = 20;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _number;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [self.tableArray objectAtIndex:indexPath.row];
    _newsNumber = _numberModel.modelId;
    if ([model.image isEqualToString:@"#"]) {
        NoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        NSString *value = [NSString stringWithFormat:@"评论:%ld", (long)model.cmtCount];
        [cell.labelDiscuss setText:value];
        cell.labelTitle.text = model.title;
        [cell.labelTime setText:model.pubDate];
        return cell;
    } else {
        OtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        NSString *value = [NSString stringWithFormat:@"评论:%ld", (long)model.cmtCount];
        [cell.labelDiscuss setText:value];
        cell.labelTitle.text = model.title;
        [cell.labelTime setText:model.pubDate];
        [cell.labelImage setImageWithURL:[NSURL URLWithString:model.image]];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
#pragma mark -
#pragma 代理进入详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FirstModel *model = [self.tableArray objectAtIndex:indexPath.row];
    [self.delegate jionTheNext:model];
}


#pragma mark -
#pragma 刷新
- (void)scrollView:(UIScrollView *)scrollView loadWithState:(LoadState)state
{
    if (state == PullDownLoadState) {
        [self performSelector:@selector(downLoadEnd) withObject:nil afterDelay:2];
    } else {
        [self performSelector:@selector(upLoadEnd) withObject:nil afterDelay:2];
    }
}
- (void)create
{
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        NSArray *array = [NSArray arrayWithObjects:@"301", @"700", @"2", @"5", @"120", nil];
        NSString *value1 = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/cms/channels/%@", [array objectAtIndex:_newsNumber - 1]];
        [ConnectModel getConnectWith:value1 paramaters:nil block:^(NSMutableData *data){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            NSArray *array = [dic objectForKey:@"articleList"];
            [_tableArray removeAllObjects];
            for (NSDictionary *myDic in array) {
                NewsModel *model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:myDic];
                [_tableArray addObject:model];
                [model release];
            }
            [self.tableView reloadData];
            
        }];
//    } else {
//        self.imageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
//        _tableView.userInteractionEnabled = NO;
//        [_imageView setBackgroundImage:[UIImage imageNamed:@"com.png"] forState:UIControlStateNormal];
//        [_imageView addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_imageView];
//        [_imageView release];
//    }
}

#pragma mark -
#pragma 断网之后再次加载试图
//- (void)refresh:(id)sender
//{
//    [_imageView removeFromSuperview];
//    self.tableView.userInteractionEnabled = YES;
//    [self.tableView reloadData];
//}

#pragma mark -
#pragma 下拉刷新
- (void)downLoadEnd
{
//    _number = 20;
    _tableView.canPullUp = YES;
    [self create];
    [_tableView reloadData];
    [_tableView stopLoadWithState:PullDownLoadState];
}
#pragma mark -
#pragma 上拉加载
- (void)upLoadEnd
{
    if (_number + 20 >= _tableArray.count) {
//        _tableView.canPullUp = YES;
        if (_number == _tableArray.count) {
            [_tableView stopLoadWithState:PullUpLoadState];
        } else{
            _number = _tableArray.count;
            [_tableView reloadData];
            [_tableView stopLoadWithState:PullUpLoadState];
        }
    } else {
    _number += 20;
    [_tableView reloadData];
    [_tableView stopLoadWithState:PullUpLoadState];
    }
}





@end
