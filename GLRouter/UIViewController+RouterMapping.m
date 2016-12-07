//
//  UIViewController+RouterMapping.m
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "UIViewController+RouterMapping.h"
#import "UIViewController+Router.h"

@implementation UIViewController (RouterMapping)

+ (NSDictionary *)router_controllerClassMapping
{
    NSDictionary* map = @{@"c1":@"ViewController1",
                          @"c2":@"ViewController2",
                          @"c3":@"ViewController3"};
    return map;
}

@end
