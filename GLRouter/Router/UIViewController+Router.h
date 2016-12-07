//
//  UIViewController+Router.h
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Router)

@property (nonatomic, strong, readonly) NSDictionary* router_params;

/*
 closeModeBlock     用于自定义界面退出方式，当为nil时，会采用默认的退出方式
 */
- (void)router_closeControllerAnimated:(BOOL)animated closeModeBlock:(void(^)())closeModeBlock;


@end
