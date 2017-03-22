//
//  OneItemCollectionViewCell.m
//  新写项目
//
//  Created by 安松林的dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "OneItemCollectionViewCell.h"
#import "UIScrollView+PullLoad.h"
#import "NoImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HeaderViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "ConnectModel.h"

@implementation OneItemCollectionViewCell

- (void)dealloc
{
    [_imageButton release];
    [_scrollheader release];
    [_pageControl release];
    [_headerArray release];
    [_itemArray release];
    [_tableView release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerArray = [NSMutableArray array];
        self.itemArray = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height - 20) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
       // 刷新
        self.tableView.pullDelegate = self;
        _tableView.canPullDown = YES;
        _tableView.canPullUp = YES;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell1"];
        [self.tableView registerClass:[NoImageTableViewCell class] forCellReuseIdentifier:@"cell2"];
        [self.contentView addSubview:self.tableView];
        [self.tableView release];
        // 创建header
        self.scrollheader = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 150)];
        _tableView.tableHeaderView = _scrollheader;
        _scrollheader.delegate = self;
        _scrollheader.tag = 1000;
        _scrollheader.contentSize = CGSizeMake(self.contentView.frame.size.width * 7, 150);
        _scrollheader.pagingEnabled = YES;
        _scrollheader.showsHorizontalScrollIndicator = NO;
        [_scrollheader release];
        
        // 添加UIPageControl
        CGRect pageControlFrame = CGRectMake(_scrollheader.frame.size.width - 70, 120, 50, 20);
        self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
        [self.pageControl.layer setCornerRadius:8];
        [self.pageControl setNumberOfPages:5];
        self.pageControl.currentPage = 0;
        self.pageControl.enabled = YES;
        NSTimer *mytimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
        [mytimer fire];
        _number = 0;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [self.itemArray objectAtIndex:indexPath.row];
    NSMutableArray *array = [NSMutableArray arrayWithArray:_headerArray];
    [array insertObject:[_headerArray lastObject] atIndex:0];
    [array addObject:[_headerArray objectAtIndex:0]];
    // 使其可以循环滚动
    for (int i = 0; i < [array count]; i++) {
        UIScrollView *small = [[UIScrollView alloc] initWithFrame:CGRectMake(i * self.contentView.frame.size.width, 0, self.contentView.frame.size.width, 150)];
        small.delegate = self;
        [_tableView.tableHeaderView addSubview:small];
        [small release];
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, small.frame.size.width, small.frame.size.height)];
        imageButton.tag = 100 + i;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageButton.frame.size.width, imageButton.frame.size.height)];
        [imageButton addSubview:image];
        NSDictionary *dic = [array objectAtIndex:i];
        [image setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]]];
        
        // header点击事件
        [imageButton addTarget:self action:@selector(jionDetail:) forControlEvents:UIControlEventTouchUpInside];
        [small addSubview:imageButton];
        [imageButton release];
        [image release];
    }

    
    if ([model.image isEqualToString:@"#"]) {
        NoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        NSString *value = [NSString stringWithFormat:@"评论:%ld", (long)model.cmtCount];
        [cell.labelDiscuss setText:value];
        cell.labelTitle.text = model.title;
        [cell.labelTime setText:model.pubDate];
        return cell;
    } else {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        NSString *value = [NSString stringWithFormat:@"评论:%ld", (long)model.cmtCount];
        [cell.labelDiscuss setText:value];
        cell.labelTitle.text = model.title;
        [cell.labelTime setText:model.pubDate];
        [cell.labelImage setImageWithURL:[NSURL URLWithString:model.image]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FirstModel *model = [self.itemArray objectAtIndex:indexPath.row];
    [self.delegate jionNewsDetail:model];
}

#pragma mark -
#pragma button点击事件传详情页面的网址
- (void)jionDetail:(UIButton *)button
{
    HeaderViewController *header = [[HeaderViewController alloc] init];
    FirstModel *model = [[FirstModel alloc] init];
    if (button.tag < 101 + [_headerArray count]) {
        NSDictionary *dic = [_headerArray objectAtIndex:button.tag - 101];
//        [header.urlDic setObject:[dic objectForKey:@"url"] forKey:@"url"];
//        [header.urlDic setObject:[dic objectForKey:@"title"] forKey:@"title"];
        model.title = [dic objectForKey:@"title"];
        model.url = [dic objectForKey:@"url"];
    }
    [self.delegate jionHeaderDetail:model];
    [header release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark -
#pragma 使其可以循环播放
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000) {
        if (scrollView.contentOffset.x == 0) {
            [scrollView setContentOffset:CGPointMake([_headerArray count] * scrollView.frame.size.width, 0)];
        } else if (scrollView.contentOffset.x == ([_headerArray count] + 1)* scrollView.frame.size.width) {
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
        }
    }
}



#pragma mark -
#pragma 是其可以按pageControl切换
- (void)scrollToNextPage:(id)sender
{
    NSInteger pageNum = self.pageControl.currentPage;
    CGSize viewsize = self.scrollheader.frame.size;
    CGRect rect = CGRectMake(viewsize.width * (pageNum + 2), 0, viewsize.width, viewsize.height);
    [self.scrollheader scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum == _headerArray.count) {
        CGRect newRect = CGRectMake(viewsize.width, 0, viewsize.width, viewsize.height);
        [self.scrollheader scrollRectToVisible:newRect animated:NO];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollheader.frame.size.width;
    int currentPage = floor((self.scrollheader.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage == 0) {
        self.pageControl.currentPage = _headerArray.count - 1;
    } else if (currentPage == _headerArray.count + 1) {
        self.pageControl.currentPage = 0;
    }
    self.pageControl.currentPage = currentPage - 1;
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
        [ConnectModel getConnectWith:@"http://mrobot.pconline.com.cn/v2/cms/channels/999"  paramaters:nil block:^(NSMutableData*data){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            NSArray *array = [dic objectForKey:@"articleList"];
            [_itemArray removeAllObjects];
            for (NSDictionary *myDic in array) {
                NewsModel *model = [[NewsModel alloc] init];
                model.state = 0;
                [model setValuesForKeysWithDictionary:myDic];
                [_itemArray addObject:model];
                [model release];
            }
            [_tableView reloadData];
        }];
//    } else {
//        self.imageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
//        [_imageView setBackgroundImage:[UIImage imageNamed:@"com.png"] forState:UIControlStateNormal];
//        [_imageView addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
//        _tableView.userInteractionEnabled = NO;
//        [self.contentView addSubview:_imageView];
//        [_imageView release];
//    }
}

#pragma mark -
#pragma 断网之后再次加载视图
//- (void)refresh:(id)sender
//{
//    [_imageView removeFromSuperview];
//    _tableView.userInteractionEnabled = YES;
//    [self.tableView reloadData];
//}

- (void)downLoadEnd
{
    _number = 30;
    [_tableView reloadData];
    _tableView.canPullUp = YES;
    [self create];
    [_tableView stopLoadWithState:PullDownLoadState];
}

- (void)upLoadEnd
{
   
    if (_number >= _itemArray.count) {
        _tableView.canPullUp = NO;
        [_tableView stopLoadWithState:PullUpLoadState];
        return;
    }
     _number +=20;
    [_tableView reloadData];
   [_tableView stopLoadWithState:PullUpLoadState];
    
}



@end
