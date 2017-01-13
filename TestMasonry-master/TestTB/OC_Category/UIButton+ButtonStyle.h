//
//  UIButton+ButtonStyle.h
//  RRArt
//
//  Created by Wujg on 15/9/13.
//  Copyright (c) 2015年 QuantGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    EButtonStyle_Default = 0,
    EButtonStyle_Login,
    EButtonStyle_Register,
    EButtonStyle_Shopping,
    EButtonStyle_CancelWhite,
    EButtonStyle_AddPicture
} EButtonStyle;

@interface UIButton (ButtonStyle)

+ (UIButton *)buttonWithStyle:(EButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector;

- (UIImage *)buttonImageFromColor:(UIColor *)color;

- (void)defaultStyle;
- (void)loginStyle;
- (void)registerStyle;
- (void)shoppingStyle;
- (void)cancelWhiteStyle;
- (void)addPictureStyle;
@end
