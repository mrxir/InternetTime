//
//  SUMMONER+CoreDataClass.h
//  InternetTime
//
//  Created by MrXir on 2017/8/17.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "LOL.h"

NS_ASSUME_NONNULL_BEGIN

@interface SUMMONER : NSManagedObject

@property (nonatomic, strong) LOL *lol;

/**
 释放Q技能
 
 @param completion 释放回调
 */
- (void)Q:(SkillReleaseCompletion)completion;

/**
 释放W技能
 
 @param completion 释放回调
 */
- (void)W:(SkillReleaseCompletion)completion;

/**
 释放E技能
 
 @param completion 释放回调
 */
- (void)E:(SkillReleaseCompletion)completion;

/**
 释放R技能
 
 @param completion 释放回调
 */
- (void)R:(SkillReleaseCompletion)completion;

@end

NS_ASSUME_NONNULL_END

#import "SUMMONER+CoreDataProperties.h"
