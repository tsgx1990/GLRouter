//
//  UIViewController+Router.m
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

@interface UIViewController()

@property (nonatomic, strong) NSDictionary* router_private_params;

@end

@implementation UIViewController (Router)

- (UIViewController*)router_openController:(NSString*)routerUrl paramsBlock:(NSDictionary*(^)(UIViewController* controller))paramsBlock openModeBlock:(void(^)(UIViewController* controller))openModeBlock;
{
    NSDictionary* urlParams = nil;
    Class vcClass = [self router_classForRouterUrl:routerUrl urlParams:&urlParams];
    if (vcClass) {
        UIViewController* controller = [[vcClass alloc] init];
        if (paramsBlock) {
            NSDictionary* params = paramsBlock(controller);
            if (urlParams.count || params.count) {
                NSMutableDictionary* mParams = @{}.mutableCopy;
                [mParams addEntriesFromDictionary:urlParams];
                [mParams addEntriesFromDictionary:params];
                controller.router_private_params = mParams;
            }
        }
        if (openModeBlock) {
            openModeBlock(controller);
        }
        else {
            UIViewController* presentedVC = [[UIApplication sharedApplication].delegate window].rootViewController;
            while (presentedVC.presentedViewController) {
                presentedVC = presentedVC.presentedViewController;
            }
            if ([presentedVC isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController*)presentedVC pushViewController:controller animated:YES];
            }
            else {
                [presentedVC presentViewController:controller animated:YES completion:nil];
            }
        }
        return controller;
    }
    return nil;
}

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

- (Class)router_classForRouterUrl:(NSString*)routerUrl urlParams:(NSDictionary**)urlParams
{
    if (!routerUrl.length) {
        NSLog(@"router error!!! 001_routerUrl: <%@> 错误😢", routerUrl);
        return nil;
    }
    
    Class rCls = NSClassFromString(routerUrl);
    if (rCls) {
        if ([rCls isSubclassOfClass:[UIViewController class]]) {
            return rCls;
        }
        else {
            NSLog(@"[%@] is not a viewController", rCls);
        }
    }
    
    NSString* escapeUrl = [routerUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL* URL = [NSURL URLWithString:escapeUrl];
    
    NSString* hostStr = URL.host;
    if (!hostStr.length) {
        NSLog(@"router error!!! host: <%@> , 002_routerUrl: <%@> 错误😢", hostStr, routerUrl);
        return nil;
    }
    
    NSString* schemaStr = URL.scheme;
    Class vcClass = nil;
    if ([schemaStr isEqualToString:@"router"]) {
        vcClass = NSClassFromString(hostStr);
    }
    else if ([schemaStr isEqualToString:@"clsmap"] && [UIViewController respondsToSelector:@selector(router_controllerClassMapping)]) {
        id cls = [[UIViewController router_controllerClassMapping] valueForKey:hostStr];
        if ([cls isKindOfClass:[NSString class]]) {
            vcClass = NSClassFromString(cls);
        }
        else {
            vcClass = cls;
        }
    }
    else {
        NSLog(@"router error!!! {%@} 协议不支持😢, 003_routerUrl: <%@>", schemaStr, routerUrl);
        return nil;
    }
    
    if (![vcClass isSubclassOfClass:[UIViewController class]]) {
        NSLog(@"router error!!! [%@] 对应的控制器不存在😢, 004_routerUrl: <%@>", hostStr, routerUrl);
        return nil;
    }
    else {
        // 解析 routerUrl 中的参数
        NSArray* pathComponents = URL.pathComponents;
//        NSLog(@"pathComponents:%@", pathComponents);
        if (pathComponents.count > 2) {
            NSMutableDictionary* mDic = [NSMutableDictionary dictionaryWithCapacity:pathComponents.count/2];
            for (int i=1; i+1<pathComponents.count; i+=2) {
                NSString* key = pathComponents[i];
                id value = pathComponents[i+1];
                [mDic setValue:value forKey:key];
            }
            *urlParams = mDic;
        }
    }
    return vcClass;
}

- (void)setRouter_private_params:(NSDictionary *)router_private_params
{
    objc_setAssociatedObject(self, @selector(router_private_params), router_private_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)router_private_params
{
    return objc_getAssociatedObject(self, _cmd);
}

- (NSDictionary *)router_params
{
    return self.router_private_params;
}

@end
