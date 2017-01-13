//
//  UIActionSheet+Common.h
//  EMeal_Cook
//
//  Created by Wujg on 15/10/17.
//  Copyright (c) 2015年 Wujg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Common)
+ (instancetype)bk_actionSheetCustomWithTitle:(NSString *)title
                                 buttonTitles:(NSArray *)buttonTitles
                             destructiveTitle:(NSString *)destructiveTitle
                                  cancelTitle:(NSString *)cancelTitle
                           andDidDismissBlock:(void (^)(UIActionSheet *sheet, NSInteger index))block;

@end
