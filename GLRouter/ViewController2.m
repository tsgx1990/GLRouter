//
//  ViewController2.m
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "ViewController2.h"
#import "UIViewController+Router.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor purpleColor];
    btn2.frame = CGRectMake(20, 220, 160, 60);
    [btn2 setTitle:@"撤退" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btn2Pressed:(UIButton*)sender
{
    [self router_closeControllerAnimated:YES closeModeBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
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
