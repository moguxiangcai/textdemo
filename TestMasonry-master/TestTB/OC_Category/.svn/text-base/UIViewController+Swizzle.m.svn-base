//
//  UIViewController+Swizzle.m
//  RRArt
//
//  Created by Wujg on 15/9/28.
//  Copyright © 2015年 QuantGroup. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "ObjcRuntime.h"
#import "RDVTabBarController.h"
@implementation UIViewController (Swizzle)

- (void)customViewDidAppear:(BOOL)animated {

    if ([NSStringFromClass([self class]) rangeOfString:@"_RootViewController"].location != NSNotFound) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
        DebugLog(@"setTabBarHidden:NO --- customViewDidAppear : %@", NSStringFromClass([self class]));
    }
    [self customViewDidAppear:animated];
}

- (void)customViewWillDisappear:(BOOL)animated {
    //返回按钮
    if (!self.navigationItem.backBarButtonItem && self.navigationController.viewControllers.count > 1) {
        //设置返回按钮(backBarButtonItem的图片不能设置；如果用leftBarButtonItem属性，则iOS7自带的滑动返回功能会失效)
        self.navigationItem.backBarButtonItem = [self custombackBarButtonItem];
    }
    [self customViewWillDisappear:animated];
}

- (void)customviewWillAppear:(BOOL)animated {
    if ([[self.navigationController childViewControllers] count] > 1) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
         [self.navigationController setToolbarHidden:YES animated:YES];
        DebugLog(@"setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass([self class]));
    }
  
    [self customviewWillAppear:animated];
}


#pragma mark BackBtn M
- (UIBarButtonItem *)custombackBarButtonItem {
    NSDictionary *textAttributes;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    barButtonItem.target = self;
    if ([barButtonItem respondsToSelector:@selector(setTitleTextAttributes:forState:)]) {
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavBackButtonFontSize],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    barButtonItem.action = @selector(goBack_Swizzle);
    return barButtonItem;
}

- (void)goBack_Swizzle {
    if ([NSStringFromClass([self class]) rangeOfString:@"ShopOrderViewController"].location != NSNotFound) {
         [self.navigationController popoverPresentationController];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
    }
   
}

+ (void)load{
    swizzleAllViewController();
}
@end

void swizzleAllViewController() {
    Swizzle([UIViewController class], @selector(viewDidAppear:), @selector(customViewDidAppear:));
    Swizzle([UIViewController class], @selector(viewWillDisappear:), @selector(customViewWillDisappear:));
    Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(customviewWillAppear:));
}
