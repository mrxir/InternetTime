//
//  MRCoreData.m
//  MRCoreData
//
//  Created by MrXir on 2017/7/30.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "MRCoreData.h"

@interface MRCoreData ()

@end

@implementation MRCoreData

#pragma mark - public method

- (instancetype)initWithFolderName:(NSString *)folderName fileName:(NSString *)fileName modelName:(NSString *)modelName
{
    if (self = [super init]) {
                
        self->_folderName = folderName;
        
        self->_fileName = fileName;
        
        self->_modelName = modelName;
        
        self->_databaseFile = [NSString stringWithFormat:@"%@/%@", self.folderName, self.fileName];
        
        [self managedObjectContext];
        
    }
    
    return self;
    
}

- (BOOL)saveContext:(NSError **)error
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    BOOL flag = NO;
    
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges]) {
            
            return [managedObjectContext save:error];
            
        }
    }
    
    return flag;
    
}

#pragma mark - setter and getter

@synthesize managedObjectContext = _managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

@synthesize managedObjectModel = _managedObjectModel;

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSError *anyError = nil;

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *folderURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.folderName];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:folderURL withIntermediateDirectories:YES attributes:nil error:&anyError];
    if (anyError) NSLog(@"%@", anyError);
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.databaseFile];
    
    self->_databaseFile = storeURL.path;
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES), NSInferMappingModelAutomaticallyOption: @(YES)};
    
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&anyError];
    if (anyError) NSLog(@"%@", anyError);
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)description
{
    NSDictionary *descriptionInfo = @{@"folderName": self.folderName,
                                      @"fileName": self.fileName,
                                      @"modelName": self.modelName,
                                      @"databaseFile": self.databaseFile};
    
    NSString *description = [NSString stringWithFormat:@"<%@: %p> %@", [super class], self, descriptionInfo];
    
    return description;
}


@end
