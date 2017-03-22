//
//  ProductDetailViewController.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/4.
//  Copyright (c) 2015年  All rights reserved.
//


#import "ProductDetailViewController.h"
#import "ProductDetailTableViewCell.h"
#import "ProductForumViewController.h"
#import "ProductDetailModel.h"
#import "Singleton.h"
#import "ToolModel.h"
#import "ContactModel.h"
#import "UIImageView+WebCache.h"
@interface ProductDetailViewController ()<UITableViewDataSource, UITableViewDelegate, ContactDelegate>

@end

@implementation ProductDetailViewController

- (void)dealloc
{
    [_detailTableView release];
    [_detailArray release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113) style:UITableViewStylePlain];
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        [self.view addSubview:_detailTableView];
        [_detailTableView release];

        self.detailArray = [NSMutableArray array];
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
    NSString *str = [NSString stringWithFormat:@"%ld", (long)share.line];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:str forKey:@"brandId"];
    switch (share.state) {
        case 0:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/types/20937" parmaters:dic delegate:self];
        }
            break;
        case 1:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/types/79849" parmaters:dic delegate:self];
        }
            break;
        case 2:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/types/20807" parmaters:dic delegate:self];
        }
            break;
        case 3:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/types/20928" parmaters:dic delegate:self];
        }
            break;
        case 4:
        {
            [ContactModel contactStartConnectUrl:@"http://mrobot.pconline.com.cn/v3/product/types/95585" parmaters:dic delegate:self];
        }
            break;
        default:
            break;
    }
}

- (void)contect:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
    NSArray *array = [dic objectForKey:@"data"];
    for (NSDictionary *myDic in array) {
        ProductDetailModel *model = [[ProductDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:myDic];
        [_detailArray addObject:model];
        [model release];
    }
    [_detailTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_detailArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Singleton *share = [Singleton shareInstance];
    static NSString *str = @"detailcell";
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[ProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] autorelease];
    }
    ProductDetailModel *model = [_detailArray objectAtIndex:indexPath.row];
    [cell.img setImageWithURL:[NSURL URLWithString:model.idxPic]];
    cell.title.text = model.shortName;
    NSString *price = [NSString stringWithFormat:@"￥ %ld", (long)model.price];
    cell.price.text = price;
    switch (share.state) {
        case 0:
        {
            cell.cpu.text = @"CPU";
            cell.size.text = @"主屏尺寸";
            cell.config.text = [model.items lastObject];
            for (int i = 0; i < [model.items count]; i ++) {
                NSString *str = [model.items objectAtIndex:i];
                if ([str isEqualToString:@"主屏尺寸"]) {
                    cell.dimensions.text = [model.items objectAtIndex:i+1];
                }
            }
        }
            break;
        case 1:
        case 3:
        {
            cell.cpu.text = [model.items objectAtIndex:0];
            cell.size.text = [model.items objectAtIndex:2];
            cell.config.text = [model.items objectAtIndex:1];
            cell.dimensions.text = [model.items objectAtIndex:3];
        }
            break;
        case 2:
        {
            cell.cpu.text = @"内存容量";
            cell.size.text = @"显卡芯片";
            cell.dimensions.text = [model.items lastObject];
            for (int i = 0; i < [model.items count]; i ++) {
                NSString *str = [model.items objectAtIndex:i];
                if ([str isEqualToString:@"内存容量"]) {
                    cell.config.text = [model.items objectAtIndex:i+1];
                }
            }
        }
        case 4:
        {
            cell.cpu.text = @"屏幕尺寸";
            cell.size.text = @"重量";
            cell.dimensions.text = [model.items lastObject];
            for (int i = 0; i < [model.items count]; i ++) {
                NSString *str = [model.items objectAtIndex:i];
                if ([str isEqualToString:@"屏幕尺寸"]) {
                    cell.config.text = [model.items objectAtIndex:i+1];
                }
            }
        }
            break;
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Singleton *share = [Singleton shareInstance];
    ProductDetailModel *model = [_detailArray objectAtIndex:indexPath.row];
    ProductForumViewController *forum = [[[ProductForumViewController alloc] init] autorelease];
    share.urlid = model.id;
    forum.urlId = model.id;
    [self.navigationController pushViewController:forum animated:YES];
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
