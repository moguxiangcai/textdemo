//
//  UILabel+Common.h
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/8.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width;
- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;
- (void)setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth;
+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;

+ (UILabel *)creatRedPointLabel;
+ (instancetype)label;

+ (instancetype)labelWithTitle:(NSString *)title;

// 已知区域重新调整
- (CGSize)contentSize;

// 不知区域，通过其设置区域
- (CGSize)textSizeIn:(CGSize)size;

//- (void)layoutInContent;
@end

@interface InsetLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets contentInset;

@end


