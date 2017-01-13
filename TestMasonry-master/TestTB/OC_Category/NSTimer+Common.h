//
//  NSTimer+Common.h
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/5/14.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Common)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)())block repeats:(BOOL)yesOrNo;
@end
