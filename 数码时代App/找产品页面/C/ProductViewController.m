//
//  MainViewController.m
//  A段产品页面
//
//  Created by chaziyjs on 14/12/29.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ProductViewController.h"
#import "ProductType1TableViewCell.h"
#import "ProductType2TableViewCell.h"
#import "ProductType3TableViewCell.h"
#import "ProductType4TableViewCell.h"
#import "ProductType5TableViewCell.h"
#import "ProductListModel.h"
#import "ContactModel.h"
#import "ToolModel.h"
#import "ProductListViewController.h"
#import "Singleton.h"
#import "LogInViewController.h"


#pragma mark -
#pragma 主页面布局

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)dealloc
{
    [_array release];
    [_mainTable release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
        self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113) style:UITableViewStylePlain];
        self.mainTable.dataSource = self;
        self.mainTable.delegate = self;
        self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTable];
        [_mainTable release];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品";
    [self creatButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width * 0.5628;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

        static NSString *str = @"product1Pool";
        ProductType1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[ProductType1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
        }
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *str = @"product2Pool";
        ProductType2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[ProductType2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
        }
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    }

    if (indexPath.row == 2) {
        static NSString *str = @"product3Pool";
        ProductType3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[ProductType3TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
        }
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    }

    if (indexPath.row == 3) {
        static NSString *str = @"product4Pool";
        ProductType4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[ProductType4TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
        }
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    }
    else {
        static NSString *str = @"product5Pool";
        ProductType5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[[ProductType5TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
        }
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Singleton *share = [Singleton shareInstance];
    NSInteger num = 1;
    num += indexPath.row;
    if (num == 1) {
        share.state = 0;
    }
    else
    {
        share.state = num - 1;
    }
    ProductListViewController *list = [[[ProductListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:list animated:YES];
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
