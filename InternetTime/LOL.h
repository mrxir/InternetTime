//
//  LOL.h
//  InternetTime
//
//  Created by MrXir on 2017/8/17.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import <MRCoreData/MRCoreData.h>

@class SUMMONER;

/**
 技能释放错误码
 
 - SkillReleaseErrorCodeSuccess:            释放成功
 - SkillReleaseErrorCodeNotColdDown:        尚未冷却
 - SkillReleaseErrorCodeNotEnoughEnergy:    能量不足
 - SkillReleaseErrorCodeNotEnoughBlue:      蓝量不足
 - SkillReleaseErrorCodeNotEnoughRed:       血量不足
 */
typedef NS_ENUM(NSUInteger, SkillReleaseErrorCode) {
    SkillReleaseErrorCodeSuccess,
    SkillReleaseErrorCodeNotColdDown,
    SkillReleaseErrorCodeNotEnoughEnergy,
    SkillReleaseErrorCodeNotEnoughBlue,
    SkillReleaseErrorCodeNotEnoughRed,
};

typedef void(^SkillReleaseCompletion)(BOOL success);

@interface LOL : MRCoreData

+ (instancetype)staticInstance;

- (SUMMONER *)summoner_instance;

- (SUMMONER *)summoner_recent;

@end

#import "SUMMONER+CoreDataClass.h"

