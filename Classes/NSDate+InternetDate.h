//
//  NSDate+InternetDate.h
//  InternetTime
//
//  Created by MrXir on 2017/8/14.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^InternetDateCompletion)(NSDate *internetDate, NSError *error);

@interface NSDate (InternetDate)

+ (void)internetDateWithURL:(NSURL *)url completion:(InternetDateCompletion)completion;

@end
