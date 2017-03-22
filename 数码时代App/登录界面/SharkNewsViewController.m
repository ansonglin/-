//
//  SharkNewsViewController.m
//  数码时代App
//
//  Created by chaziyjs on 15/1/10.
//  Copyright (c) 2015年  All rights reserved.
//

#import "SharkNewsViewController.h"
#import "ConnectModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "ShakeNewsDetailViewController.h"

@interface SharkNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SharkNewsViewController

- (void)dealloc
{
    [_shakeTable release];
    [_shakeImage release];
    [_shakeArray release];
    [_shakeBackPic release];
    [_backButton release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.shakeArray = [NSMutableArray array];
        self.shakeBackPic = [[UIImageView alloc] init];
        [self.shakeBackPic setImage:[UIImage imageNamed:@"shakeBackImg.png"]];
        self.shakeBackPic.userInteractionEnabled = YES;
        [self.view addSubview:_shakeBackPic];
        [_shakeBackPic release];

        self.shakeTable = [[UITableView alloc] init];
        _shakeTable.delegate = self;
        _shakeTable.dataSource = self;
        _shakeTable.backgroundColor = [UIColor clearColor];
        [_shakeBackPic addSubview:_shakeTable];
        [_shakeTable release];


        self.state = 0;

        self.backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
        [self.shakeBackPic addSubview:_backButton];
        [_backButton release];


    }
    return self;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = [_shakeArray count] / 30;
    [self createImage];
}

- (void)createImage
{
    self.shakeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_shakeImage setImage:[UIImage imageNamed:@"shakePic.png"]];
    [self.view addSubview:_shakeImage];
    [_shakeImage release];
}


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   // 使手机可以震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [ConnectModel getConnectWith:@"http://mrobot.pconline.com.cn/v2/cms/channels/999" paramaters:nil block:^(NSMutableData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
        NSArray *array = [dic objectForKey:@"articleList"];
        [_shakeArray removeAllObjects];
        for (NSDictionary *myDic in array) {
            NewsModel *model = [[NewsModel alloc] init];
            model.state = 0;
            [model setValuesForKeysWithDictionary:myDic];
            [_shakeArray addObject:model];
            [model release];
        }
        _count += [_shakeArray count] / 30;
    }];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event

{
    if(motion == UIEventSubtypeMotionShake)
    {
        if (_state == 0 || _state == 1 || _state == 2 || _state == 3 || _state == 4) {
            [UIView transitionFromView:_shakeImage toView:_shakeBackPic duration:1.0f options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished) {
                if (_state == 0) {
                    [_shakeImage removeFromSuperview];
                }
                self.shakeBackPic.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.shakeTable.frame = CGRectMake(0, _shakeBackPic.frame.size.height / 3, _shakeBackPic.frame.size.width, _shakeBackPic.frame.size.height / 3);
                self.backButton.frame = CGRectMake(_shakeBackPic.frame.size.width * 2 / 5, _shakeBackPic.frame.size.height  / 5 + 10, _shakeBackPic.frame.size.width / 5, 30);
                [_shakeBackPic bringSubviewToFront:_backButton];
                _count += [_shakeArray count] / 30;
                _state ++;
                [_shakeTable reloadData];
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"每日只能摇5次哦!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

- (void)buttonAction
{
    _state = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"shakecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NewsModel *news = [_shakeArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    [cell.imageView setImageWithURL:[NSURL URLWithString:news.image]];
    cell.textLabel.text = news.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShakeNewsDetailViewController *detail = [[ShakeNewsDetailViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detail];
    navi.navigationBar.translucent = NO;
    FirstModel *news = [_shakeArray objectAtIndex:indexPath.row];
    detail.model = news;
    [self presentViewController:navi animated:YES completion:nil];
    [detail release];

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
