//
//  NSTimer+Common.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/5/14.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "NSTimer+Common.h"

@implementation NSTimer (Common)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)())block repeats:(BOOL)yesOrNo{
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)blockInvoke:(NSTimer *)timer{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
