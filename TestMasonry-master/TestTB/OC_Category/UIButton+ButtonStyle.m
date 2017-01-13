//
//  UIButton+ButtonStyle.m
//  RRArt
//
//  Created by Wujg on 15/9/13.
//  Copyright (c) 2015年 QuantGroup. All rights reserved.
//

#import "UIButton+ButtonStyle.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (ButtonStyle)

+ (UIButton *)buttonWithStyle:(EButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    const  SEL selArray[] = {@selector(defaultStyle), @selector(loginStyle), @selector(registerStyle), @selector(shoppingStyle), @selector(cancelWhiteStyle), @selector(addPictureStyle)};
    if ([btn respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [btn performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return btn;
}

- (UIImage *)buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)defaultStyle {
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:self.titleLabel.font.pointSize]];
}

- (void)loginStyle {
    [self defaultStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x11a7ed"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x189ee1"]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x189ee1" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateDisabled];
}

- (void)registerStyle {
    [self defaultStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x71c9f5"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x63c4f5"]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x63c4f5" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateDisabled];
}

- (void)shoppingStyle {
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xf1c232"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xe1ba43"]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xf1c232" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateDisabled];
}

- (void)cancelWhiteStyle {
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xffffff"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xececec"]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithHexString:@"0x019bee"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithHexString:@"0x019bee"] forState:UIControlStateHighlighted];
    self.layer.cornerRadius = 3.5;
    self.layer.masksToBounds = YES;
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:self.titleLabel.font.pointSize]];
}

- (void)addPictureStyle {
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x00dab2"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x00bd9a"]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithHexString:@"0xdddddd" andAlpha:0.8] forState:UIControlStateHighlighted];
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:self.titleLabel.font.pointSize]];
}

@end
