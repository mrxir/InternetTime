//
//  NSDate+InternetDate.m
//  InternetTime
//
//  Created by MrXir on 2017/8/14.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "NSDate+InternetDate.h"

@implementation NSDate (InternetDate)

+ (void)internetDateWithURL:(NSURL *)url completion:(InternetDateCompletion)completion
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0f];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSError *anyError = connectionError;
        
        if (!anyError) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            NSDictionary *allHeaderFields = nil;
            if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
                allHeaderFields = httpResponse.allHeaderFields;
                
                /* [ANALYZE] Like -> Date: Fri, 11 Aug 2017 10:07:15 GMT */
                
                /* No.1 */
                NSString *dateGMTString = [httpResponse.allHeaderFields valueForKey:@"date"];
                
                /* No.2 */
                NSDateFormatter *dateGMTFormatter = [[NSDateFormatter alloc] init];
                dateGMTFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                dateGMTFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss zzz";
                
                /* No.3 */
                NSDate *dateGMT = [dateGMTFormatter dateFromString:dateGMTString];
                
                if (!dateGMT) {
                    NSString *reason = [NSString stringWithFormat:@"或许日期串'%@' 无法与格式 '%@' 进行匹配, 无法解析获得远程日期, 将获取系统日期.", dateGMTString, dateGMTFormatter.dateFormat];
                    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                    userInfo[NSURLPathKey] = url;
                    userInfo[NSLocalizedFailureReasonErrorKey] = NSLocalizedString(reason, nil);
                    userInfo[NSURLLocalizedLabelKey] = response;
                    anyError = [NSError errorWithDomain:@"InternetDateErrorDomin" code:7782000 userInfo:userInfo];
                    if (completion != NULL) completion([NSDate date], anyError);
                } else {
                    if (completion != NULL) completion(dateGMT, nil);
                }
                
            } else {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[NSURLPathKey] = url;
                userInfo[NSLocalizedFailureReasonErrorKey] = NSLocalizedString(@"无 allHeaderFields 属性, 无法解析获得远程日期, 将获取系统日期.", nil);
                userInfo[NSURLLocalizedLabelKey] = response;
                anyError = [NSError errorWithDomain:@"InternetDateErrorDomin" code:7782404 userInfo:userInfo];
                
                if (completion != NULL) completion([NSDate date], anyError);
            }
            
        } else {
            if (completion != NULL) completion([NSDate date], anyError);
        }
        
    }];
}

@end
