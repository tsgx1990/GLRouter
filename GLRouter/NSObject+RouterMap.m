//
//  NSObject+RouterMap.m
//  GLRouter
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "NSObject+RouterMap.h"
#import "NSObject+Router.h"

@implementation NSObject (RouterMap)

+ (NSDictionary *)router_controllerClassMapping
{
    NSDictionary* map = @{@"c1":@"ViewController1",
                          @"c2":@"ViewController2",
                          @"c3":@"ViewController3"};
    return map;
}

@end
