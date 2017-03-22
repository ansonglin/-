//
//  NewsViewController.m
//  新写项目
//
//  Created by 安松林的dlios on 14-12-31.
//  Copyright (c) 2014年  All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCollectionViewCell.h"
#import "ConnectModel.h"
#import "NewsModel.h"
#import "SortModel.h"
#import "DetailViewController.h"
#import "OneItemCollectionViewCell.h"
#import "HeaderViewController.h"
#import "LogInViewController.h"
@interface NewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NewsCollectionViewCellDelegate,OneItemCollectionViewCellDelegate>

@end

@implementation NewsViewController
- (void)dealloc
{
    [_button release];
    [_buttonArray release];
    [_collection release];
    [_headerArray release];
    [_collectionArray release];
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectionArray = [NSMutableArray array];
        self.buttonArray = [NSMutableArray array];
        self.headerArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"资讯";
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    [self creatButton];
    [self createVC];
    [self createData];
    
}

-(void)creatButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    [button addTarget:self action:@selector(Aaction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
    [button release];
    [bar release];
}
-(void)Aaction:(id)sender
{
    LogInViewController *log = [[LogInViewController alloc] init];
    log.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:log animated:YES completion:nil];
    [log release];
    
}

#pragma mark -
#pragma 创建视图
- (void)createVC
{
    NSArray *array = [NSArray arrayWithObjects:@"头条", @"超极本", @"MID", @"新品", @"iPhone", @"DIY", nil];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < [array count]; i++) {
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(self.view.frame.size.width / 6 * i, 0, self.view.frame.size.width / 6, scroll.frame.size.height);
        [_button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:_button];
        [scroll addSubview:_button];
    }
    self.button = [self.buttonArray objectAtIndex:0];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button.layer setCornerRadius:10.0];
    [self.view addSubview:scroll];
    [scroll release];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 115);
    [flow setMinimumLineSpacing:0]; // 列距为零
    // 左右滑动
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, scroll.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 113 - scroll.frame.size.height) collectionViewLayout:flow];
    self.collection.pagingEnabled = YES;
    self.collection.showsHorizontalScrollIndicator = NO;
    _collection.bounces = NO;
    [_collection setBackgroundColor:[UIColor whiteColor]];
    // 注册cell
    [self.collection registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"news"];
    [self.collection registerClass:[OneItemCollectionViewCell class] forCellWithReuseIdentifier:@"one"];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    [self.view addSubview:self.collection];
    [flow release];
    [_collection release];
}
#pragma mark -
#pragma button点击事件
- (void)buttonAction:(UIButton *)button
{
    [self.collection setContentOffset:CGPointMake(button.frame.origin.x * 6, 0) animated:YES];
}

#pragma mark -
#pragma 获取数据
- (void)createData
{
    NSArray *array = [NSArray arrayWithObjects:@"999", @"301", @"700", @"2", @"5", @"120", nil];
    NSString *value = @"http://mrobot.pconline.com.cn/v2/cms/channels/999";
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        [ConnectModel getConnectWith:value paramaters:nil block:^(NSMutableData*data){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            NSArray *array = [dic objectForKey:@"articleList"];
            SortModel *sortModel = [[SortModel alloc] init];
            for (NSDictionary *myDic in array) {
                NewsModel *model = [[NewsModel alloc] init];
                model.state = 0;
                [model setValuesForKeysWithDictionary:myDic];
                [sortModel.touTiaoArray addObject:model];
                [model release];
            }
            sortModel.modelId = 0;
            [self.collectionArray addObject:sortModel];
            // header
            NSArray *arrayHeader = [dic objectForKey:@"focus"];
            [self.headerArray addObjectsFromArray:arrayHeader];
            [self.collection reloadData];
        }];
        for (int i = 0; i < 6; i++) {
            if (i == 0) {
                continue;
            }
            NSString *value1 = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/cms/channels/%@", [array objectAtIndex:i]];
            [ConnectModel getConnectWith:value1 paramaters:nil block:^(NSMutableData*data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                NSArray *array = [dic objectForKey:@"articleList"];
                SortModel *sortModel = [[SortModel alloc] init];
                for (NSDictionary *myDic in array) {
                    NewsModel *model = [[NewsModel alloc] init];
                    model.state = i;
                    [model setValuesForKeysWithDictionary:myDic];
                    [sortModel.sortArray addObject:model];
                    [model release];
                }
                sortModel.modelId = i;
                [self.collectionArray addObject:sortModel];
                [sortModel release];
                [self.collection reloadData];
            }];
        }
}

#pragma mark -
#pragma 断网之后再次刷新
//- (void)dianji:(id)sender
//{
////    [_imageView removeFromSuperview];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    [self.view setFrame:CGRectMake(rect.origin.x, rect.origin.y + 64, rect.size.width, rect.size.height)];
//    [self viewDidLoad];
//}



#pragma mark -
#pragma  排序
- (NSMutableArray *)sortUseBlock:(NSArray *)array
{
    NSMutableArray *myArray = [NSMutableArray arrayWithArray:array];
    [myArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        SortModel *first = (SortModel *)obj1;
        SortModel *second = (SortModel *)obj2;
        if (first.modelId > second.modelId) {
            return NSOrderedDescending;
        }
        else if (first.modelId == second.modelId)
        {
            return NSOrderedSame;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
    return myArray;
}

#pragma mark -
#pragma 返回item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *array = [NSMutableArray array];
    array = [self sortUseBlock:self.collectionArray];
    [self.collectionArray removeAllObjects];
    [self.collectionArray addObjectsFromArray:array];
    return [self.collectionArray count];
}
#pragma mark -
#pragma 给cell赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortModel *model = [self.collectionArray objectAtIndex:indexPath.item];
    if (indexPath.item == 0) {
        OneItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"one" forIndexPath:indexPath];
        cell.delegate = self;
        [cell.itemArray removeAllObjects];
        [cell.itemArray addObjectsFromArray:model.touTiaoArray];
        [cell.headerArray removeAllObjects];
        [cell.headerArray addObjectsFromArray:_headerArray];
        [cell.tableView reloadData];
        // 调用下拉刷新的方法
        if ([cell.itemArray count] != 0) {
            [cell downLoadEnd];
        }
        return cell;
    } else {
        NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"news" forIndexPath:indexPath];
        cell.delegate = self;
        
        cell.numberModel = model;
        [cell.tableArray removeAllObjects];
        [cell.tableArray addObjectsFromArray:model.sortArray];
        [cell.tableView reloadData];
        return cell;
    }
}

#pragma mark -
#pragma 点击button使视图做相应的调整
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    for (int i = 0; i < 6; i++) {
        if (i == self.collection.contentOffset.x / self.view.frame.size.width) {
            self.button = [self.buttonArray objectAtIndex:i];
            [self.button setBackgroundColor:[UIColor whiteColor]];
            [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.button.layer setCornerRadius:10.0];
        } else {
            self.button = [self.buttonArray objectAtIndex:i];
             [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            
        }
    }
}
#pragma mark -
#pragma 点击视图使button做相应的调整
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (int i = 0; i < 6; i++) {
        if (i == scrollView.contentOffset.x / self.view.frame.size.width) {
            self.button = [self.buttonArray objectAtIndex:scrollView.contentOffset.x / self.view.frame.size.width];
             [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.button setBackgroundColor:[UIColor whiteColor]];
            [self.button.layer setCornerRadius:10.0];
        } else {
            self.button = [self.buttonArray objectAtIndex:i];
             [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -
#pragma 点击进入详情
- (void)jionTheNext:(FirstModel *)model
{
    DetailViewController *news = [[DetailViewController alloc] init];
    self.tabBarController.navigationController.navigationItem.hidesBackButton = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:news animated:YES];
    news.model = model;
    [news release];
}
- (void)jionNewsDetail:(FirstModel *)model
{
    DetailViewController *news = [[DetailViewController alloc] init];
//    self.tabBarController.navigationController.navigationItem.hidesBackButton = YES;
//    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:news animated:YES];
    news.model = model;
    [news release];
}
- (void)jionHeaderDetail:(FirstModel *)dic
{
    HeaderViewController *header = [[HeaderViewController alloc] init];
    [self.navigationController pushViewController:header animated:YES];
    header.urlDic = dic;
    [header release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
