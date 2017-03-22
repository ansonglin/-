//
//  CollectViewController.m
//  数码时代App
//
//  Created by 安松林的dlios on 15-1-12.
//  Copyright (c) 2015年  All rights reserved.
//

#import "CollectViewController.h"
#import "CollectTableViewCell.h"
#import "NewsDataBase.h"
#import "FirstModel.h"
#import "NewsModel.h"
#import "CollectDetailViewController.h"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CollectViewController
- (void)dealloc
{
    [_tableView release];
    [_button release];
    [_array release];
    [super dealloc];
}
- (void)awakeFromNib
{
    self.array = [NSMutableArray array];
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.translucent=NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"收藏";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlePic.png"] forBarMetrics:UIBarMetricsDefault];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [_tableView registerClass:[CollectTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    [self createButton];
    [self createRight];
}


- (void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"8.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(5, 5, 40, 40);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)buttonAction:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FirstModel *model = [_array objectAtIndex:indexPath.row];
    [cell.labelname setText:model.title];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CollectDetailViewController *detail = [[CollectDetailViewController alloc] init];
    FirstModel *model = [_array objectAtIndex:indexPath.row];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
#pragma mark -
#pragma 自定义button
- (void)createRight
{
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [_button setTitle:@"编辑" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(addToAtion:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:_button] autorelease];
    [_button release];
}
- (void)addToAtion:(UIBarButtonItem *)sender
{
    if ([_button.currentTitle isEqualToString:@"编辑"]) {
        [_tableView setEditing:YES];
        [_button setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        [_tableView setEditing:NO];
        [_button setTitle:@"编辑" forState:UIControlStateNormal];
    }
}
#pragma mark -
#pragma 使其处于编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据库里面的数据
        FirstModel *model = [_array objectAtIndex:indexPath.row];
        [NewsDataBase delegateNewsModel:model];
        
        [_array removeObjectAtIndex:indexPath.row];
        [_button setTitle:@"完成" forState:UIControlStateNormal];
        [tableView reloadData];
    }
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
