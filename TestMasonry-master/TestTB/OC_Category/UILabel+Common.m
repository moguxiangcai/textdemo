//
//  UILabel+Common.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/8.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "UILabel+Common.h"
#import "ObjcRuntime.h"

@implementation UILabel (Common)

+(void)load{
    
    
    Swizzle([self class], @selector(willMoveToSuperview:), @selector(wtj_willMoveToSuperview:));
}

- (void)wtj_willMoveToSuperview:(nullable UIView *)newSuperview{
    [self wtj_willMoveToSuperview:newSuperview];
    
    
    if (self) {
        
        if (newSuperview) {
            
            if (self.tag == 10086) {
                self.font = [UIFont systemFontOfSize:self.font.pointSize];
                
            } else {
                if ([UIFont fontNamesForFamilyName:CustomFontName])
                    self.font  = [UIFont fontWithName:CustomFontName size:self.font.pointSize];
            }
        
        }
    }
    
    
}

+ (instancetype)label
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title
{
    UILabel *label = [UILabel label];
    
    label.text = title;
    return label;
}

- (CGSize)contentSize
{
    return [self textSizeIn:self.bounds.size];
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    UILabel *label = [self new];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = textColor;
    return label;
}

- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width {
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight {
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}

- (void)setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth {
    self.numberOfLines = 0;
    self.text = str;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = resultSize.height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

+(UILabel *)creatRedPointLabel{
    UILabel * redPoint = [[UILabel alloc]init];
    
    redPoint.layer.masksToBounds=YES;
    redPoint.layer.cornerRadius = 6/2;
    redPoint.backgroundColor=[UIColor redColor];
    
    return redPoint;
    
}
- (CGSize)textSizeIn:(CGSize)size
{
    NSLineBreakMode breakMode = self.lineBreakMode;
    UIFont *font = self.font;
    
    CGSize contentSize = CGSizeZero;
    //    if ([IOSDeviceConfig sharedConfig].isIOS7)
    //    {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary* attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    //    }
    //    else
    //    {
    //        contentSize = [self.text sizeWithFont:font constrainedToSize:size lineBreakMode:breakMode];
    //    }
    
    
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    return contentSize;
}
@end



@implementation InsetLabel


- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _contentInset)];
}


- (CGSize)contentSize
{
    CGRect rect = UIEdgeInsetsInsetRect(self.bounds, _contentInset);
    CGSize size = [super textSizeIn:rect.size];
    return CGSizeMake(size.width + _contentInset.left + _contentInset.right, size.height + _contentInset.top + _contentInset.bottom);
}

- (CGSize)textSizeIn:(CGSize)size
{
    size.width -= _contentInset.left + _contentInset.right;
    size.height -= _contentInset.top + _contentInset.bottom;
    CGSize textSize = [super textSizeIn:size];
    return CGSizeMake(textSize.width + _contentInset.left + _contentInset.right, textSize.height + _contentInset.top + _contentInset.bottom);
}

@end

