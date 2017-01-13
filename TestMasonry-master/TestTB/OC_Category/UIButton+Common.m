//
//  UIButton+Common.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/7.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "UIButton+Common.h"
#import <objc/runtime.h>
static const void *s_HYBUIControltouchUpEventBlckkey = "s_HYBUIControltouchUpEventBlckkey";
@implementation UIButton (Common)

+ (UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image hlImage:(UIImage *)hlImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:CustomFontName size:15];
    
    button.frame = frame;
    if (nil != image) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (nil != hlImage) {
        [button setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    }
    return button;
}

+(UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image selectImage:(UIImage *)selectImage{
    
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.titleLabel.font = [UIFont fontWithName:CustomFontName size:15];
    [button setAdjustsImageWhenHighlighted:NO];
    
    if (nil != image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (nil != selectImage) {
        [button setImage:selectImage forState:UIControlStateHighlighted];
        [button setImage:selectImage forState:UIControlStateSelected];
        
    }
    return button;
    
}

+(UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:CustomFontName size:15];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"0x858585"] forState:UIControlStateNormal];
    
    return button;
    
}

+(UIButton *)createButtonBorderBlueColor:(CGRect)frame andTitle:(NSString *)titile{
    UIButton *loginBarkButton=[[UIButton alloc]initWithFrame:frame];
    loginBarkButton.layer.masksToBounds=YES;
    loginBarkButton.layer.cornerRadius=4.5;
    loginBarkButton.layer.borderColor=kColorNavBG.CGColor;
    loginBarkButton.layer.borderWidth=1;
    [loginBarkButton setTitle:titile forState:UIControlStateNormal];
    [loginBarkButton setTitleColor:kColorNavBG forState:UIControlStateNormal];
    loginBarkButton.titleLabel.font=[UIFont fontWithName:CustomFontName size:14];
    return loginBarkButton;
}

-(void)setBk_addEventHandler:(bk_addEventHandlerBlock)bk_addEventHandler{
    objc_setAssociatedObject(self, s_HYBUIControltouchUpEventBlckkey, bk_addEventHandler, OBJC_ASSOCIATION_COPY);
    
    [self removeTarget:self action:@selector(hybOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (bk_addEventHandler) {
        [self addTarget:self action:@selector(hybOnTouchUp:)  forControlEvents:UIControlEventTouchUpInside];
    }
    
}


-(bk_addEventHandlerBlock)bk_addEventHandler{
    return objc_getAssociatedObject(self, s_HYBUIControltouchUpEventBlckkey);
    
}


-(void)hybOnTouchUp:(UIButton *)sender{
    if (self.bk_addEventHandler) {
        self.bk_addEventHandler(sender);
    }
}

-(void)bk_addEventHandler:(bk_addEventHandlerBlock)block{
    self.bk_addEventHandler = block;
}
@end
