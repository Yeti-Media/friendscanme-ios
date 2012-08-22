//
//  FSMAppDelegate.h
//  friendscanme
//
//  Created by Nick Treadway on 8/21/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FSMAppDelegate : UIResponder <UIApplicationDelegate>

extern NSString *const FBSessionStateChangedNotification;

@property (strong, nonatomic) UIWindow *window;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
