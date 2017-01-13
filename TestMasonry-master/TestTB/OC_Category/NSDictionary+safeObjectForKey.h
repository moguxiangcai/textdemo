//
//  NSDictionary+safeObjectForKey.h
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/15.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define checkNull(__X__)    (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@interface NSDictionary (safeObjectForKey)

/*!返回一个安全的可变字典*/
+ (NSMutableDictionary *)safeDictionary:(NSDictionary *)dict;

/*!通过key检查value是否为NSNull*/
- (NSString *)safeObjectForKey:(id)key;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSDictionary *)InfoDictionary;
@end
