 //
//  ScrollViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-5.
//  Copyright (c) 2015年  All rights reserved.
//

#import "ScrollViewController.h"
#import "FourTableScrollTableViewCell.h"
#import "FourModel.h"
#import "FourScrollModel.h"
#import "ConnectModel.h"
#import "UIImageView+WebCache.h"
#import "LuanTanViewController.h"
@interface ScrollViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}
@end

@implementation ScrollViewController
-(void)dealloc
{
    [_model release];
    [_arr release];
    [_data release];
    
    [super dealloc];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.arr = [NSMutableArray array];
        self.data = [NSMutableData data];
        }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatTable];
    [self creatJson];
    // Do any additional setup after loading the view.
}
//http://mrobot.pconline.com.cn/v3/itbbs/newForums/587012?orderby=replyat&pageNo=1&pageSize=20
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatJson
{
//    if ([ConnectModel judgeConnectEnabled] == YES) {
        NSString *str = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/itbbs/newForums/%@",self.model.forumId];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"replyat" forKey:@"orderby"];
        [dic setObject:@"1" forKey:@"pageNo"];
        [dic setObject:@"20" forKey:@"pageSize"];
        [ConnectModel getConnectWith:str paramaters:dic block:^(NSMutableData*data){
            self.data = data;
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *newArray = [dic objectForKey:@"topicList"];
            for (NSMutableDictionary *myDic in newArray) {
                FourScrollModel *model = [[FourScrollModel alloc] init];
                [model setValuesForKeysWithDictionary:myDic];
                [self.arr addObject:model];
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
-(void)creatTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.rowHeight = table.frame.size.height/2;
    table.dataSource = self;
    table.delegate = self;
    [table registerClass:[FourTableScrollTableViewCell class] forCellReuseIdentifier:@"cell"];
    [table release];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FourTableScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FourScrollModel *model = [_arr objectAtIndex:indexPath.row];
    [cell.imageDig setImageWithURL:[NSURL URLWithString:model.image]];
    [cell.alable setText:model.title];
    [cell.blable setText:model.message];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FourScrollModel *model = [_arr objectAtIndex:indexPath.row];
   // 自适应高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName, nil];
    CGRect rect = [model.message boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 20, 1000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:dic context:nil];
    CGFloat hight = rect.size.height + (self.view.frame.size.width -20) * 9 / 16 + 60;
    return hight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LuanTanViewController *luan = [[LuanTanViewController alloc] init];
    FourScrollModel *model = [_arr objectAtIndex:indexPath.row];
    [luan getModelLunTan:model];
    [self.navigationController pushViewController:luan animated:YES];
    [luan release];
    
}
-(void)getScrollModel:(FourModel*)model
{
    self.model = model;
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
