//
//  ProductInformationCollectionViewCell.m
//  A段产品页面
//
//  Created by chaziyjs on 15/1/6.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ProductInformationCollectionViewCell.h"
#import "ProductForumWebViewController.h"
#import "ProductForumTableViewCell.h"
#import "ProductForumModel.h"
#import "Singleton.h"
#import "ToolModel.h"
#import "ContactModel.h"

@implementation ProductInformationCollectionViewCell

- (void)dealloc
{
    [_table release];
    [_forumArray release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.forumArray = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, self.frame.size.height - 153) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    [self.contentView addSubview:_table];
    [_table release];
    [self StartConnect];
}

- (void)StartConnect
{
    Singleton *share = [Singleton shareInstance];
    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/information/%ld", (long)share.urlid];
    [ContactModel contactStartConnectUrl:url parmaters:nil delegate:self];
}

- (void)contect:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
    NSArray *array = [dic objectForKey:@"articleList"];
    for (NSDictionary *mydic in array) {
        ProductForumModel *model = [[ProductForumModel alloc] init];
        [model setValuesForKeysWithDictionary:mydic];
        [_forumArray addObject:model];
        [model release];
    }
    [_table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_forumArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width * 0.3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cellpool";
    ProductForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[ProductForumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    ProductForumModel *model = [_forumArray objectAtIndex:indexPath.row];
    cell.forumtitle.text = model.title;
    NSString *date = [model.pubDate substringToIndex:10];
    cell.date.text = date;
    cell.channel.text = model.channel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductForumModel *model = [_forumArray objectAtIndex:indexPath.row];
    [self.viewdelegate pageIntoUrl:model.url];
}


@end
