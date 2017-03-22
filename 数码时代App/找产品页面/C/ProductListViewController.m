//
//  ProductListViewController.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductListViewController.h"
#import "ProductListModel.h"
#import "ContactModel.h"
#import "ToolModel.h"
#import "Singleton.h"
#import "UIImageView+WebCache.h"
@interface ProductListViewController ()<UITableViewDataSource, UITableViewDelegate, ContactDelegate>

@end

@implementation ProductListViewController

- (void)dealloc
{
    [_listArray release];
    [_recommond release];
    [_listTableView release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.listArray = [NSMutableArray array];
        self.recommond = [NSDictionary dictionary];
        self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.separatorStyle = NO;
        [self.view addSubview:_listTableView];
        [_listTableView release];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startConnect];
}

- (void)startConnect {
    Singleton *share = [Singleton shareInstance];
    switch (share.state) {
        case 0:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/brand/20937" parmaters:nil delegate:self];
        }
            break;
        case 1:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/brand/79849" parmaters:nil delegate:self];
        }
            break;
        case 2:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/brand/20807" parmaters:nil delegate:self];
        }
            break;
        case 3:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/brand/20928" parmaters:nil delegate:self];
        }
            break;
        case 4:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/brand/95585" parmaters:nil delegate:self];
        }
            break;
        default:
            break;
    }
}


- (void)contect:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
    NSDictionary *part = [dic objectForKey:@"partition"];
    self.recommond = [part objectForKey:@"recommondBrands"];
    NSArray *array = [_recommond objectForKey:@"brands"];
    for (NSDictionary *myDic in array) {
        ProductListModel *model = [[ProductListModel alloc] init];
        [model setValuesForKeysWithDictionary:myDic];
        [_listArray addObject:model];
        [model release];
    }
    [_listTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width / 3
    ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"listpool";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
    }
    ProductListModel *model = [_listArray objectAtIndex:indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.textLabel.text = model.name;
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellback.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Singleton *share = [Singleton shareInstance];
    ProductListModel *model = [_listArray objectAtIndex:indexPath.row];
    share.line = model.id;
    ProductDetailViewController *detail = [[[ProductDetailViewController alloc] init] autorelease];
    [self.navigationController pushViewController:detail animated:YES];
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
