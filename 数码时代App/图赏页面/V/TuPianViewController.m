//
//  TuPianViewController.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "TuPianViewController.h"
#import "MyModel.h"
#import "UIImageView+WebCache.h"
#import "ConnectModel.h"
#import "ThreeModel.h"
#import "TuShuangTableViewCell.h"


@interface TuPianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UIButton*bButton;
}
@end

@implementation TuPianViewController
-(void)dealloc
{
    [_data release];
    [_model release];
    [_threeModel release];
    [_arr release];
    [_scroll release];
    [_image release];
    [_Digarr release];
    [_name release];
    
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        [ConnectModel getConnectWith:self.model.url paramaters:nil block:^(NSMutableData *data){
            self.data = data;
            [self createJsonObject];
            [self creatScroll];
            [table reloadData];
        }];
//    } else {
//        self.imageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        [_imageView setBackgroundImage:[UIImage imageNamed:@"com.png"] forState:UIControlStateNormal];
//        [_imageView addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_imageView];
//        [_imageView release];
//    }
}

#pragma mark -
#pragma 断网之后再次刷新
//- (void)dianji:(id)sender
//{
//    [_imageView removeFromSuperview];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    [self.view setFrame:CGRectMake(rect.origin.x, rect.origin.y + 64, rect.size.width, rect.size.height)];
//    [self viewDidLoad];
//}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.arr = [NSMutableArray array];
        self.data = [NSMutableData data];
        self.Digarr = [NSMutableArray array];
    }
    return self;
}
-(void)creatButton
{
    UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 50,22)];
    [abutton setImage:[UIImage imageNamed:@"8.png"] forState:UIControlStateNormal];
//    关闭点击图片后显示的亮度
    [abutton setAdjustsImageWhenHighlighted:NO];
    [abutton addTarget:self action:@selector(Aaction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:abutton];
    self.navigationItem.leftBarButtonItem = bar;
    bButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 22)];
    [bButton setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
    [bButton setAdjustsImageWhenHighlighted:NO];
    [bButton addTarget:self action:@selector(Baction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc] initWithCustomView:bButton];
    self.navigationItem.rightBarButtonItem = bar1;
    [bar release];
    [abutton release];
    [bar1 release];
    [bButton release];
}
-(void)Aaction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)Baction:(id)sender
{
    
    if (_a == 0) {
        [bButton setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
        [self creatTable];
        _a = 1;
    }else if (_a == 1)
    {
        [bButton setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
        [table removeFromSuperview];
        _a = 0;
    }
}

-(void)creatTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2/3, 10, self.view.frame.size.width/3, self.view.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[TuShuangTableViewCell class] forCellReuseIdentifier:@"aaa"];
    [table setRowHeight:table.frame.size.height/5];
    [self.view addSubview:table];
    [table release];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_Digarr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuShuangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    ThreeModel *model = [_Digarr objectAtIndex:indexPath.row];
    //[cell.imageView setFrame:CGRectMake(10, 10,cell.frame.size.width- 20 , cell.frame.size.height - 20)];
    [cell.imageV setImageWithURL:[NSURL URLWithString:model.thumb]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 选中图片显示当前图片
    _scroll.contentOffset = CGPointMake(self.view.frame.size.width * indexPath.row, 0);
}

#pragma mark-
#pragma mark json
-(void)createJsonObject
{
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *newArray = [dic objectForKey:@"photos"];
    for (NSMutableDictionary *myDic in newArray) {
        ThreeModel *model = [[ThreeModel alloc] init];
        [model setValuesForKeysWithDictionary:myDic];
        [self.Digarr addObject:model];
        
    }
   
}
-(void)creatScroll
{
    UILabel *alable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
    [self.view addSubview:alable];
    [alable setTextAlignment:NSTextAlignmentCenter];
    [alable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [alable setText:self.name];
    [alable release];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 64- 49)];
    [_scroll setBackgroundColor:[UIColor whiteColor]];
    [_scroll setPagingEnabled:YES];
    [_scroll setShowsHorizontalScrollIndicator:NO];
    [_scroll setContentSize:CGSizeMake(self.view.frame.size.width*([_Digarr count]), 0)];
    [_scroll setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_scroll];
    NSInteger n = 1;
    for (int i  = 1; i <= ([_Digarr count]); i ++) {
        UIScrollView *scrolla = [[UIScrollView alloc] initWithFrame:CGRectMake(self.scroll.frame.size.width*(i - 1), 0, self.scroll.frame.size.width, self.scroll.frame.size.height )];
        [self.scroll addSubview:scrolla];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, scrolla.frame.size.width, scrolla.frame.size.height);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
        ThreeModel *model = [_Digarr objectAtIndex:n - 1];
        [image setImageWithURL:[NSURL URLWithString:model.url]];
        [button addTarget:self action:@selector(imageAtion) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:image];
        [scrolla addSubview:button];
        [_scroll addSubview:scrolla];
        n++;
        [image release];
        [scrolla release];
    }
    [_scroll release];
    
}

- (void)imageAtion
{
    if (_a == 1) {
        [bButton setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
        [table removeFromSuperview];
        _a = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getValue:(MyModel*)model NsArray:(NSMutableArray*)array flag:(BOOL)flag
{
    self.arr = array;
    self.model = model;
    self.flag = flag;
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
