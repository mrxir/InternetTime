//
//  SUMMONER+CoreDataClass.m
//  InternetTime
//
//  Created by MrXir on 2017/8/17.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "SUMMONER+CoreDataClass.h"

#import <UIKit/UIKit.h>

#import <UIView+Toast.h>

@implementation SUMMONER

@synthesize lol = _lol;

- (void)Q:(SkillReleaseCompletion)completion
{
    NSDate *localNowDate = [NSDate date];
    
    NSTimeInterval localNowTimestamp = [localNowDate timeIntervalSince1970];
    
    NSTimeInterval cd = MAX(0, self.cdQ - (localNowTimestamp - self.timestampQ));
    
    if (cd > 0) {
        if (completion != NULL) completion(NO);
    } else {
        self.timestampQ = localNowTimestamp;
        [self.lol saveContext:nil];
        if (completion != NULL) completion(YES);
    }
    
}

- (void)W:(SkillReleaseCompletion)completion
{
    NSDate *localNowDate = [NSDate date];
    
    NSTimeInterval localNowTimestamp = [localNowDate timeIntervalSince1970];
    
    NSTimeInterval cd = MAX(0, self.cdW - (localNowTimestamp - self.timestampW));
    
    if (cd > 0.5) {
        if (completion != NULL) completion(NO);
    } else {
        self.timestampW = localNowTimestamp;
        [self.lol saveContext:nil];
        if (completion != NULL) completion(YES);
    }
}

- (void)E:(SkillReleaseCompletion)completion
{
    NSDate *localNowDate = [NSDate date];
    
    NSTimeInterval localNowTimestamp = [localNowDate timeIntervalSince1970];
    
    NSTimeInterval cd = MAX(0, self.cdE - (localNowTimestamp - self.timestampE));
    
    if (cd > 0) {
        if (completion != NULL) completion(NO);
    } else {
        self.timestampE = localNowTimestamp;
        [self.lol saveContext:nil];
        if (completion != NULL) completion(YES);
    }
}

- (void)R:(SkillReleaseCompletion)completion
{
    NSDate *localNowDate = [NSDate date];
    
    NSTimeInterval localNowTimestamp = [localNowDate timeIntervalSince1970];
    
    NSTimeInterval cd = MAX(0, self.cdR - (localNowTimestamp - self.timestampR));
    
    if (cd > 0) {
        if (completion != NULL) completion(NO);
    } else {
        self.timestampR = localNowTimestamp;
        [self.lol saveContext:nil];
        if (completion != NULL) completion(YES);
    }
}

@end
