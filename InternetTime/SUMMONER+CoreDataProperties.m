//
//  SUMMONER+CoreDataProperties.m
//  InternetTime
//
//  Created by MrXir on 2017/8/18.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "SUMMONER+CoreDataProperties.h"

@implementation SUMMONER (CoreDataProperties)

+ (NSFetchRequest<SUMMONER *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SUMMONER"];
}

@dynamic cdE;
@dynamic cdQ;
@dynamic cdR;
@dynamic cdW;
@dynamic level;
@dynamic magicResistance;
@dynamic nickname;
@dynamic physicalResistanc;
@dynamic realname;
@dynamic timestampE;
@dynamic timestampQ;
@dynamic timestampR;
@dynamic timestampW;
@dynamic nameQ;
@dynamic nameW;
@dynamic nameE;
@dynamic nameR;

@end
