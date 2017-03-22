//
//  KJAnimationViewController.m
//  数码时代App
//
//  Created by dlios on 15-1-10.
//  Copyright (c) 2015年  All rights reserved.
//

#import "KJAnimationViewController.h"

@interface KJAnimationViewController ()
{
    UIImageView *image;
    
}
@end

@implementation KJAnimationViewController
-(void)dealloc
{
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatImageView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatImageView
{
    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [image setImage:[UIImage imageNamed:@"等待图.png"]];
    [self.view addSubview:image];
    [image release];
    
//    [UIView animateWithDuration:2 delay:1 options: UIViewAnimationOptionTransitionCurlUp
//                     animations:^{
////        [UIView setAnimationRepeatAutoreverses:YES];
//                image.frame = CGRectMake(self.view.frame.size.width *2, self.view.frame.size.height, 0,0);
//    } completion:^(BOOL finished) {
//        
//    }];
    
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
