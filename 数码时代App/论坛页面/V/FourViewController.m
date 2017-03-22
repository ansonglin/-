//
//  FourViewController.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "FourViewController.h"
#import "FourModel.h"
#import "ConnectModel.h"
#import "UIImageView+WebCache.h"
#import "DeViewController.h"
#import "ScrollViewController.h"
#import "FourTableViewCell.h"
#import "FourCollectionViewCell.h"
#import "DeFirstViewController.h"
#import "ScrollViewController.h"
#import "ButtonViewController.h"
#import "LogInViewController.h"
@interface FourViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    UIScrollView *ScrollView;
    UITableView *table;
    UICollectionView*coll;
}
@end

@implementation FourViewController
-(void)dealloc
{
    [_Array release];
    [_ArrayTable release];
    [_data release];
    [_data1 release];
    [_timer release];
    
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createJsonTable];
    self.navigationItem.title = @"论坛广场";
//    [self creatButton];
    [self create];
//    [coll scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[_Array count] inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self addNSTimer];
    [self creatButton];
        // Do any additional setup after loading the view.
}
- (void)create
{
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        [ConnectModel getConnectWith:DetailUrl1 paramaters:nil block:^(NSMutableData*data){
            self.data = data;
            [self createJsonObject];
            [self creatLuanTan];
        }];
//    } else {
//        self.imageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
//        [_imageView setBackgroundImage:[UIImage imageNamed:@"com.png"] forState:UIControlStateNormal];
//        [_imageView addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_imageView];
//        [_imageView release];
//    }
}
#pragma mark -
#pragma 断网之后再次刷新界面
//- (void)refresh:(id)sender
//{
//    [_imageView removeFromSuperview];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    self.view.frame = CGRectMake(rect.origin.x, rect.origin.y + 64, rect.size.width, rect.size.height - 113);
//    [self viewDidLoad];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.data = [NSMutableData data];
        self.Array = [NSMutableArray array];
        self.ArrayTable = [NSMutableArray array];
        self.data1 = [NSMutableData data];
    }
    return self;
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

#pragma mark-
#pragma mark json
-(void)createJsonObject
{
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *newArray = [dic objectForKey:@"focus"];
    for (NSMutableDictionary *myDic in newArray) {
        FourModel *model = [[FourModel alloc] init];
        [model setValuesForKeysWithDictionary:myDic];
        [self.Array addObject:model];
    }
}
-(void)createJsonTable
{
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        [ConnectModel getConnectWith:DetailUrl2 paramaters:nil block:^(NSMutableData*data){
            self.data1 = data;
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.data1 options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *newArray = [dic objectForKey:@"forums"];
            for (NSMutableDictionary *myDic in newArray) {
                FourModel *model = [[FourModel alloc] init];
                [model setValuesForKeysWithDictionary:myDic];
                [self.ArrayTable addObject:model];
            }
            [table reloadData];
        }];
//    } else {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
//        imageView.image = [UIImage imageNamed:@"com.png"];
//        [self.view addSubview:imageView];
//        [imageView release];
//    }
}

#pragma mark-
#pragma mark 论坛广场
-(void)creatLuanTan
{
#pragma -mark
#pragma UITableView
    table = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height ) style:UITableViewStylePlain];
    [table setRowHeight:80];
    [table registerClass:[FourTableViewCell class] forCellReuseIdentifier:@"table"];
//    [table setScrollEnabled:NO];
    table.dataSource = self;
    table.delegate = self;
//
    [self.view addSubview:table];
    ScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height*3.5/5 + 50)];
   table.tableHeaderView = ScrollView;
#pragma -mark
#pragma UIButton
    NSInteger n = 0;
    for (int i = 0; i < 2; i ++) {
        for (int j = 0;j < 3; j ++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScrollView.frame.size.width/3*j + 5,ScrollView.frame.size.height/4*(i + 2) -20, ScrollView.frame.size.width/3 -10,ScrollView.frame.size.height/4 -20)];
            button.tag = n;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
            [button addSubview:image];
            NSString *str = [NSString stringWithFormat:@"%ld.png",(long)n];
            [image setImage:[UIImage imageNamed:str]];
            [button addTarget:self action:@selector(Baction:) forControlEvents:UIControlEventTouchUpInside];
//            NSInteger red = arc4random()% 255;
//            NSInteger green = arc4random()% 255;
//            NSInteger blue = arc4random() % 255;
//            UIColor *color = [UIColor colorWithRed:red / 255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
//            [button setBackgroundColor:color];
            [ScrollView addSubview:button];
            n ++;
            [image release];
            [button release];
        }
    }
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0,ScrollView.frame.size.height - 30,ScrollView.frame.size.width, 30)];
    [ScrollView addSubview:lable];
    [lable setTextAlignment:NSTextAlignmentCenter];
    [lable setText:@"热门板块"];
    [lable setFont:[UIFont systemFontOfSize:15.0f]];
    [lable setTextColor:[UIColor darkGrayColor]];
    [lable release];
#pragma -mark
#pragma 实现滚动视图 colletionView
    UICollectionViewFlowLayout *laout = [[UICollectionViewFlowLayout alloc] init];
    laout.itemSize = CGSizeMake(ScrollView.frame.size.width, ScrollView.frame.size.height/2 - 30);
//
    laout.minimumInteritemSpacing = 0;
    laout.minimumLineSpacing = 0;
    [laout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    coll = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,ScrollView.frame.size.width,ScrollView.frame.size.height/2-30) collectionViewLayout:laout];
    [coll setPagingEnabled:YES];
    [coll setBounces:NO];
    coll.dataSource =self;
    coll.delegate = self;
    [coll registerClass:[FourCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [ScrollView addSubview:coll];

    [laout release];
    [coll release];
    [ScrollView release];
    [table release];
}
-(void)addNSTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
-(void)nextPage
{
    NSIndexPath *currentIndexPath=[[coll indexPathsForVisibleItems]lastObject];
    NSInteger nextItem=currentIndexPath.item+1;
    NSInteger nextSection=currentIndexPath.section;
    if (nextItem== self.Array.count) {
        nextItem = 0;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [coll scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
-(void)removeNSTimer
{
    [self.timer invalidate];
    self.timer=nil;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_Array count];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeNSTimer];
}
//当用户停止拖拽的时候调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addNSTimer];
}

-(void)Baction:(id)sender
{
    UIButton *abutton = (UIButton*)sender;
    ButtonViewController*bu = [[ButtonViewController alloc] init];
    [bu getButton:abutton.tag];
    [self.navigationController pushViewController:bu animated:YES];
    [bu release];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_Array count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FourModel *model = [_Array objectAtIndex:indexPath.item];
    [cell.image setImageWithURL:[NSURL URLWithString:model.image]];
    [cell.alable setText:model.title];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 1) {
        DeFirstViewController *dea = [[DeFirstViewController alloc] init];
        [self.navigationController pushViewController:dea animated:YES];
        [dea release];
    }else
    {
        DeViewController *de = [[DeViewController alloc] init];
        FourModel *model = [_Array objectAtIndex:indexPath.item];
        [de getFourModel:model Array:_Array];
        [self.navigationController pushViewController:de animated:YES];
        [de release];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ArrayTable count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table"];
    FourModel *model = [_ArrayTable objectAtIndex:indexPath.row];
    [cell.alable setText:model.forumName];
    [cell.blable setText:[NSString stringWithFormat:@"帖子数:%@",model.topics]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ScrollViewController *scr = [[ScrollViewController alloc] init];
    FourModel *model = [_ArrayTable objectAtIndex:indexPath.row];
    [scr getScrollModel:model];
    [self.navigationController pushViewController:scr animated:YES];
    [scr release];
    
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
