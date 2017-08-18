//
//  SUMMONER+CoreDataProperties.h
//  InternetTime
//
//  Created by MrXir on 2017/8/18.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "SUMMONER+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SUMMONER (CoreDataProperties)

+ (NSFetchRequest<SUMMONER *> *)fetchRequest;

@property (nonatomic) float cdE;
@property (nonatomic) float cdQ;
@property (nonatomic) float cdR;
@property (nonatomic) float cdW;
@property (nonatomic) int16_t level;
@property (nonatomic) int16_t magicResistance;
@property (nullable, nonatomic, copy) NSString *nickname;
@property (nonatomic) int16_t physicalResistanc;
@property (nullable, nonatomic, copy) NSString *realname;
@property (nonatomic) double timestampE;
@property (nonatomic) double timestampQ;
@property (nonatomic) double timestampR;
@property (nonatomic) double timestampW;
@property (nullable, nonatomic, copy) NSString *nameQ;
@property (nullable, nonatomic, copy) NSString *nameW;
@property (nullable, nonatomic, copy) NSString *nameE;
@property (nullable, nonatomic, copy) NSString *nameR;

@end

NS_ASSUME_NONNULL_END
