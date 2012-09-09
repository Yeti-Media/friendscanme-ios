//
//  FSMUsersSource.h
//  friendscanme
//
//  Created by Nick Treadway on 9/6/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "FSMDataSource.h"

@interface FSMUsersSource : NSObject <RKObjectLoaderDelegate>

- (void)sendRequest:(NSString *)facebookID facebookName:(NSString *)name;

@end
