//
//  FSMAppDelegate.h
//  seed data
//
//  Created by Nick Treadway on 9/10/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
