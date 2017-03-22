//
//  ThreeViewController.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ThreeViewController.h"
#import "ConnectModel.h"
#import "MyModel.h"
#import "TuPianViewController.h"
#import "LogInViewController.h"
#import "MyTableViewCell.h"
@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ThreeViewController
-(void)dealloc
{
    [_array release];
    [_data release];
    [_table release];
    [_arr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatTable];

    self.navigationItem.title = @"图赏";
    [self creatButton];
    [self createData];
    // Do any additional setup after loading the view.
}

- (void)createData
{
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"41" forKey:@"id"];
        [ConnectModel getConnectWith:DetailUrl paramaters:dic block:^(NSMutableData*data){
            self.data = data;
            [self createJsonObject];
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
//    self.view.frame = CGRectMake(rect.origin.x, rect.origin.y + 64, rect.size.width, rect.size.height);
//    [self viewDidLoad];
//}




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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.array = [NSMutableArray array];
        self.data = [NSMutableData data];
        self.arr = [NSMutableArray array];
    }
    return self;
}
#pragma mark-
#pragma mark json
-(void)createJsonObject
{
    
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *arr1 =  [dic objectForKey:@"groups"];
    for (NSDictionary *myDic in arr1) {
        MyModel *model = [[MyModel alloc]init];
        [model setValuesForKeysWithDictionary:myDic];
        [self.array addObject:model];
    }
    [_table reloadData];
    
    
}
-(void)creatTable
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    [_table setRowHeight:_table.frame.size.height/2];
    [_table registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"fa"];
    _table.dataSource = self;
    _table.delegate = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    [_table release];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fa" forIndexPath:indexPath];
    MyModel *model = [_array objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TuPianViewController *tu = [[TuPianViewController alloc] init];
    MyModel *model = [_array objectAtIndex:indexPath.row];
    tu.name = model.name;
    [tu getValue:model NsArray:_array flag:YES];
    [self.navigationController pushViewController:tu animated:YES];
    [tu release];
    
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
