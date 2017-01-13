//
//  NSDictionary+safeObjectForKey.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/15.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"

@implementation NSDictionary (safeObjectForKey)

/*!返回一个安全的可变字典*/
+ (NSMutableDictionary *)safeDictionary:(NSDictionary *)dict
{
    NSMutableDictionary *safeDict = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
    
    NSEnumerator * enumerator = [dict keyEnumerator];
    
    id key;
    while(key = [enumerator nextObject]) {
        
        id obj = [dict safeObjectForKey:key];//检查Null
        if (nil != obj) {
            [safeDict setObject:obj forKey:key];
        } else {
            [safeDict setObject:@"" forKey:key];
        }
    }
    
    return safeDict;
}

/*!通过key检查value是否为NSNull*/
- (NSString *)safeObjectForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    return checkNull([self objectForKey:key]);
}
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
//字典转json格式字符串：

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSMutableDictionary* d = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData * jsondata=[NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)InfoDictionary{
    CUser *user = [CLogin curLoginUser];
    NSMutableDictionary *userINfo = [[NSMutableDictionary alloc] init];
    [userINfo setObject:user.userinfo.Nickname forKey:@"Nickname"];
    [userINfo setObject:@(user.userinfo.Role) forKey:@"Role"];
    [userINfo setObject:@(user.userinfo.Sex) forKey:@"Sex"];
    NSString *strUrl = [user.userinfo.Avatar substringWithRange:NSMakeRange(kOssDownloadUrl.length+1, user.userinfo.Avatar.length - (kOssDownloadUrl.length+1))];
    [userINfo setObject:strUrl forKey:@"Avatar"];
    [userINfo setObject:@(user.userinfo.Userlevel) forKey:@"Userlevel"];
    [userINfo setObject:user.userinfo.Uid forKey:@"Uid"];
    
    return userINfo.copy;

}

@end
