//
//  UIControl+Common.m
//  RRArt-iOS
//
//  Created by wtj on 16/5/3.
//  Copyright © 2016年 YiBei. All rights reserved.
//

#import "UIControl+Common.h"
#import <objc/runtime.h>

static const void *s_WTJBUIControltouchUpEventBlckkey = "s_WTJBUIControltouchUpEventBlckkey";

@implementation UIControl (Common)

-(void)setTouchUpBlock:(WTJTouchUpBlock)touchUpBlock{

    objc_setAssociatedObject(self, s_WTJBUIControltouchUpEventBlckkey, touchUpBlock, OBJC_ASSOCIATION_COPY);
    
    [self removeTarget:self action:@selector(hybOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (touchUpBlock) {
        [self addTarget:self action:@selector(hybOnTouchUp:)  forControlEvents:UIControlEventTouchUpInside];
    }

}

-(WTJTouchUpBlock)touchUpBlock{
    return objc_getAssociatedObject(self, s_WTJBUIControltouchUpEventBlckkey);
}

-(void)hybOnTouchUp:(UIButton *)sender{
    if (self.touchUpBlock) {
        self.touchUpBlock(sender);
    }
    
}

-(void)addTouchUpBlock:(WTJTouchUpBlock)block{
    self.touchUpBlock=block;
    
}
@end
