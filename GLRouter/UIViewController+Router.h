//
//  UIViewController+Router.h
//  RouterDemo
//
//  Created by guanglong on 2016/12/7.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 schema://host/key1/value1/key2/value2/key3/value3
 
 router:// 协议对应的 host 是控制器类名
 clsmap:// 协议对应的 host 是 router_controllerClassMapping 中的key
 
 如果routerUrl只传了一个控制器类名，则直接跳转到该控制器界面。
 
 */

@interface UIViewController(RouterClsMap)

/*
 如果要使用clsmap:// 协议，需要实现该方法，返回类的映射关系
 */
@property (class, strong, readonly) NSDictionary* router_controllerClassMapping;

@end

@interface UIViewController (Router)

@property (nonatomic, strong, readonly) NSDictionary* router_params;

/*
 routerUrl      一般的形式为：schema://host/key1/value1/key2/value2/key3/value3
                目前只支持两种协议：
                router:// 协议对应的 host 是控制器类名
                clsmap:// 协议对应的 host 是 router_controllerClassMapping 中的key
                如果routerUrl只传了一个控制器类名，则直接跳转到该控制器界面。
 
 paramsBlock    用于返回传递参数给controller，当为nil时，表示不传递参数
 
 openModeBlock  用于自定义跳转方式，当为nil时，会采用默认的跳转方式
 */
- (UIViewController*)router_openController:(NSString*)routerUrl paramsBlock:(NSDictionary*(^)(UIViewController* controller))paramsBlock openModeBlock:(void(^)(UIViewController* controller))openModeBlock;


/*
 closeModeBlock     用于自定义界面退出方式，当为nil时，会采用默认的退出方式
 */
- (void)router_closeControllerAnimated:(BOOL)animated closeModeBlock:(void(^)())closeModeBlock;


@end
