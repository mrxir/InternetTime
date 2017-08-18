//
//  LOL.m
//  InternetTime
//
//  Created by MrXir on 2017/8/17.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "LOL.h"

@implementation LOL

+ (instancetype)staticInstance
{
    static LOL *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[LOL alloc] init];
    });
    return s_manager;
}

- (SUMMONER *)summoner_instance
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([SUMMONER class])
                                         inManagedObjectContext:self.managedObjectContext];
}

- (SUMMONER *)summoner_recent
{
    NSFetchRequest *request = [SUMMONER fetchRequest];
    
    request.returnsObjectsAsFaults = NO;
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) NSLog(@"%@", error);
    
    if (result.count > 1) {
        NSLog(@"[警告] 发现[%d]条记录'， 但应该为 1 条。", (unsigned)result.count);
    }
    
    return result.lastObject;
}

@end
