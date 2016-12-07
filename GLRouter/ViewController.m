//
//  ViewController.m
//  GLRouter
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Router.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(20, 120, 160, 60);
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
    [self router_openController:@"clsmap://c1/title/中国/name/lgl/age/12/height" paramsBlock:^NSDictionary *(UIViewController *controller) {
        
        NSDictionary* dic = @{@"title2":@"woqu"};
        return dic;
        
    } openModeBlock:^(UIViewController *controller) {
        UIViewController* rootController = [[UIApplication sharedApplication].delegate window].rootViewController;
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:controller];
        [rootController presentViewController:navi animated:YES completion:nil];
    }];
}

- (void)btn2Pressed:(UIButton*)sender
{
    [self router_closeControllerAnimated:YES closeModeBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
