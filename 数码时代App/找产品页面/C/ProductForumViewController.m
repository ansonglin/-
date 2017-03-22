//
//  ProductForumViewController.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductForumViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductInformationCollectionViewCell.h"
#import "ProductForumWebViewController.h"

@interface ProductForumViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, collectionDelegate>

@end

@implementation ProductForumViewController

- (void)dealloc
{
    [_webView release];
    [_name release];
    [_collect release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = [NSArray arrayWithObjects:@"概述", @"参数", @"报价", @"资讯", @"点评", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

- (void)createView
{

    for (int i = 0; i < [_name count]; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0  + self.view.frame.size.width / 5 * i, 0, self.view.frame.size.width / 5, 40)];
        button.tag = 1100 + i*10;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[_name objectAtIndex:i] forState:UIControlStateNormal];
        if (i == 0) {
           [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button release];
    }
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    self.collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 49) collectionViewLayout:flow];
    [_collect registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:@"forumcell"];
    [_collect registerClass:[ProductInformationCollectionViewCell class] forCellWithReuseIdentifier:@"informationcell"];
    _collect.bounces = NO;
    _collect.pagingEnabled = YES;
    _collect.scrollEnabled = NO;
    _collect.dataSource = self;
    _collect.delegate = self;
    [self.view addSubview:_collect];
    [flow release];
    [_collect release];
}

- (void)buttonAction:(UIButton *)sender
{
    for (int i = 0; i < [_name count]; i ++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:1100 + i*10];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSInteger num = (sender.tag - 1100)/10;
    _collect.contentOffset = CGPointMake(self.view.frame.size.width * num, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
        {
            ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"forumcell" forIndexPath:indexPath];
            [cell.webView setScalesPageToFit:YES];
            NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/summary/%ld", (long)self.urlId];
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [cell.webView loadRequest:request];
            return cell;
        }
            break;
        case 1:
        {
            ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"forumcell" forIndexPath:indexPath];
            [cell.webView setScalesPageToFit:YES];
            NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/detail/%ld", (long)self.urlId];
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [cell.webView loadRequest:request];
            return cell;
        }
            break;
        case 2:
        {
            ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"forumcell" forIndexPath:indexPath];
            [cell.webView setScalesPageToFit:YES];
            NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/comparePrice/%ld", (long)self.urlId];
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [cell.webView loadRequest:request];
            return cell;
        }
            break;
        case 3:
        {
            ProductInformationCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"informationcell" forIndexPath:indexPath];
            cell.viewdelegate = self;
            [cell.table reloadData];
            return cell;
        }
            break;
        case 4:
        {
            ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"forumcell" forIndexPath:indexPath];
            [cell.webView setScalesPageToFit:YES];
            NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/comments/%ld", (long)self.urlId];
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [cell.webView loadRequest:request];
            return cell;
        }
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    for (int i = 0; i < [_name count]; i ++) {
//        UIButton *button = (UIButton *)[self.view viewWithTag:1100 + i*10];
//        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    }
//    UIButton *button = (UIButton *)[self.view viewWithTag:1100 + indexPath.item*10];
//   [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    
//}

- (void)pageIntoUrl:(NSString *)url
{
    ProductForumWebViewController *web = [[[ProductForumWebViewController alloc] init] autorelease];
    web.url = url;
    [self.navigationController pushViewController:web animated:YES];
    
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
