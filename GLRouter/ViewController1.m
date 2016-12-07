//
//  ViewController1.m
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "ViewController1.h"
#import "NSObject+Router.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.router_params[@"title"];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(120, 120, 100, 60);
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor purpleColor];
    btn2.frame = CGRectMake(20, 220, 160, 60);
    [btn2 setTitle:@"撤退" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btnPressed:(UIButton*)sender
{
    [self router_openController:@"router://ViewController2/title/君子务本" paramsBlock:^NSDictionary *(UIViewController *controller) {
        
        NSDictionary* dic = @{@"title1":self.title};
        return dic;
        
    } openModeBlock:nil];
//    ^(UIViewController *controller) {
//        [self presentViewController:controller animated:YES completion:nil];
//    }];
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
