//
//  LogInViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-8.
//  Copyright (c) 2015年  All rights reserved.
//

#import "LogInViewController.h"
#import "ShareSDK/ShareSDK.h"
#import "UIImageView+WebCache.h"
#import "ZhuanLanViewController.h"
#import "SharkNewsViewController.h"
#import "CollectViewController.h"
#import "NewsDataBase.h"
#import "CacheTableViewCell.h"
#import "WoViewController.h"
#import "SDImageCache.h"

@interface LogInViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}
@end

@implementation LogInViewController
-(void)dealloc
{
    [_img release];
//    [_button release];
    [_back release];
    [_headerView release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheState = 0;
        self.state = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor whiteColor]];

//    [self creatButton];
    [self creatTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatButton
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.back = [[UIButton alloc] init];
    self.back.frame = CGRectMake(15, 15, self.view.frame.size.width / 7, 30);
    [_back setTitle:@"返回" forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_back];
    [_back release];
//    self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 6 / 7 - 5 ,30, self.view.frame.size.width / 7, 30)];
//    [_button setTitle:@"登录" forState:UIControlStateNormal];
//    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [_button addTarget:self action:@selector(Aaction:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:_button];
//    table.tableHeaderView = view;
//    self.img = [[UIImageView alloc] init];
//    self.img.frame = CGRectMake(view.frame.size.width / 3, view.frame.size.height / 4, view.frame.size.width / 3, view.frame.size.height / 2);
//    [_img setImage:[UIImage imageNamed:@"login.png"]];
//    [_img.layer setCornerRadius:view.frame.size.height / 4];
//    _img.layer.masksToBounds = YES;
//    [view addSubview:_img];
    [_headerView release];
//    [_button release];
    [_img release];
}

//-(void)Aaction:(id)sender
//{
//    if (_state == 0) {
//        [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//            if (result) {
//                NSLog(@"授权登陆成功，已获取用户信息");
////                NSString *uid = [userInfo uid];
//                NSString *nickname = [userInfo nickname];
//                NSString *profileImage = [userInfo profileImage];
//                [_img setImageWithURL:[NSURL URLWithString:profileImage]];
//                _state = 1;
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"欢迎进入数码时代" message:[NSString stringWithFormat:@"登陆成功,昵称:%@",nickname] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [_button setTitle:@"注销" forState:UIControlStateNormal];
//                [alert show];
//            }else{
//                NSLog(@"分享失败");
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//        }];
//    }
//    else
//    {
//        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
//        [_button setTitle:@"登录" forState:UIControlStateNormal];
//        _state = 0;
//        [self.img setImage:[UIImage imageNamed:@"login.png"]];
//    }
//}

- (void)backToView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)creatTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [image setImage:[UIImage imageNamed:@"beijing.png"]];
    [self creatButton];
    table.tableHeaderView = _headerView;
    [table setBackgroundView:image];
    table.scrollEnabled = NO;
    table.dataSource = self;
    table.delegate = self;
    // 取消table样式
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.rowHeight = table.frame.size.height/12;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"asd"];
    [self.view addSubview:table];
    [image release];
    [table release];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        static NSString *str = @"cell";
        CacheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[CacheTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }
        [cell.imageView setImage:[UIImage imageNamed:@"删除.png"]];
        [cell.textLabel setText:@"清除缓存"];
        cell.backgroundColor = [UIColor clearColor];
        if (_cacheState == 0) {
            [cell.labelDetail setText:[self sizeCache]];
        } else {
            [cell.labelDetail setText:@"0.0MB"];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asd"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                [cell.imageView setImage:[UIImage imageNamed:@"专栏.png"]];
                [cell.textLabel setText:@"最新专栏信息"];
                break;
            case 1:
                [cell.imageView setImage:[UIImage imageNamed:@"head.png"]];
                [cell.textLabel setText:@"我的收藏"];
                break;
            case 3:
                [cell.imageView setImage:[UIImage imageNamed:@"摇摇.png"]];
                [cell.textLabel setText:@"摇一摇新闻"];
                break;
            case 4:
            {
                [cell.imageView setImage:[UIImage imageNamed:@"版本更新.png"]];
                [cell.textLabel setText:@"版本更新"];
            }
                break;
            case 5:
                [cell.imageView setImage:[UIImage imageNamed:@"关于.png"]];
                [cell.textLabel setText:@"关于我们"];
                break;
            default:
                break;
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {// 最新专栏信息
            ZhuanLanViewController*zhuan = [[ZhuanLanViewController alloc] init];
            [self presentViewController:zhuan animated:YES completion:nil];
            [zhuan release];
        }
            break;
        case 1:
        {// 收藏
            NSMutableArray *array = [NewsDataBase selectAllNews];
            if ([array count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前没有收藏" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [alert show];
                // 使alert定时消失
                [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timerAction:) userInfo:alert repeats:YES];
                [alert release];
            } else {
                CollectViewController *collect = [[CollectViewController alloc] init];
                collect.array = array;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:collect];
                [self presentViewController:nav animated:YES completion:nil];
                [collect release];
            }
        }
            break;
        case 2:
        {// 缓存
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            if (_cacheState == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"将要清除缓存" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [self alertView];
                [alert show];
                [alert release];
                _cacheState = 1;
                [table reloadData];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"缓存已清除" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [alert show];
                // 使alert定时消失
                [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timerAction1:) userInfo:alert repeats:YES];
                [alert release];
            }
        }
            break;
         case 3:
        {// 摇摇乐
            SharkNewsViewController *shark = [[SharkNewsViewController alloc] init];
            [self presentViewController:shark animated:YES completion:nil];
            [shark release];
        }
            break;
         case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前版本V1.0.0" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            // 使alert定时消失
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFire:) userInfo:alert repeats:YES];
            [alert release];
        }
            break;
         case 5:
        {// 关于我们
//            WoViewController *wo = [[WoViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:wo];
//            [self presentViewController:nav animated:YES completion:nil];
//            [wo release];
        }
            break;
        default:
            break;
    }
}

- (void)timerAction:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)timerAction1:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)timerFire:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)switchAction:(id)sender
{
//    if (_cacheState == 0) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"将要清除缓存" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self alertView];
    // 调用SDImageCache的缓存清除方法
    SDImageCache *Cache = [SDImageCache sharedImageCache];
    [Cache clearDisk];
    [alert show];
    [alert release];
    [table reloadData];
//    }
}


#pragma mark -
#pragma 计算缓存文件夹大小
- (long)fileSizeForDir:(NSString*)path
{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 获取每一个路径目录
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i < [array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    [fileManager release];
    return size;
}

#pragma mark -
#pragma 计算缓存大小
- (NSString *)sizeCache
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    long docSize = [self fileSizeForDir:docPath];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *ImageCachePath = [cachesDir stringByAppendingPathComponent:@"Caches"];
    long ImageCacheSize = [self fileSizeForDir:ImageCachePath];
    long totalSize = docSize + ImageCacheSize;
    const unsigned int bytes = 1024*1024 ; //字节数，如果想获取KB就1024，MB就1024*1024
    NSString *string = [NSString stringWithFormat:@"%.2fMB",(1.0 *totalSize/bytes)];
    return string;
}

#pragma mark -
#pragma 清除缓存的方法
-(void)alertView
{
    dispatch_async(dispatch_get_global_queue ( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
        // 获取文件路径
        NSString *cachPath = [ NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            // 判断文件是否存在
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        // 清除webView的缓存和cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    });
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
