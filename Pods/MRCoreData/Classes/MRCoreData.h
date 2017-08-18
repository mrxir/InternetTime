//
//  MRCoreData.h
//  MRCoreData
//
//  Created by MrXir on 2017/7/30.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface MRCoreData : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, copy, readonly) NSString *folderName;
@property (nonatomic, copy, readonly) NSString *fileName;
@property (nonatomic, copy, readonly) NSString *modelName;
@property (nonatomic, copy, readonly) NSString *databaseFile;

- (instancetype)initWithFolderName:(NSString *)folderName fileName:(NSString *)fileName modelName:(NSString *)modelName;

- (BOOL)saveContext:(NSError **)error;

- (NSString *)description;

@end
