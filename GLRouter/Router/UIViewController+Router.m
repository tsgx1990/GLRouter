//
//  UIViewController+Router.m
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

@implementation UIViewController (Router)

- (void)router_closeControllerAnimated:(BOOL)animated closeModeBlock:(void(^)())closeModeBlock;
{
    if (closeModeBlock) {
        closeModeBlock();
    }
    else {
        if (self.navigationController) {
            if (self.navigationController.viewControllers.firstObject == self) {
                [self.navigationController dismissViewControllerAnimated:animated completion:nil];
            }
            else {
                [self.navigationController popViewControllerAnimated:animated];
            }
        }
        else {
            [self dismissViewControllerAnimated:animated completion:nil];
        }
    }
}

- (void)setRouter_private_params:(NSDictionary *)router_private_params
{
    objc_setAssociatedObject(self, _cmd, router_private_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)router_params
{
    return objc_getAssociatedObject(self, @selector(setRouter_private_params:));
}

@end
