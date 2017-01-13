//
//  NSObject+Common.h
//  RRArt
//
//  Created by Wujg on 15/9/28.
//  Copyright © 2015年 QuantGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

#pragma mark Tip M
+ (NSString *)tipFromError:(NSError *)error;
+ (BOOL)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString *)tipStr;
+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
+ (void)showStatusBarError:(NSError *)error;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;
+ (void)hideStatusBar;

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;

//图片
+ (BOOL)saveImage:(UIImage *)image imageName:(NSString *)imageName inFolder:(NSString *)folderName;
+ (NSData *)loadImageDataWithName:( NSString *)imageName inFolder:(NSString *)folderName;
+ (BOOL)deleteImageCacheInFolder:(NSString *)folderName;
/// 设置本地通知
+ (void)registerLocalNotification:(NSDate *)alertTime andKey:(NSString *)key;
/// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key;
/// 取消所有本地推送通知
+(void)cancelAllLocalNotification;

#pragma mark NetError
- (id)handleResponse:(id)responseJSON;
- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end
