//
//  FSMUser.h
//  friendscanme
//
//  Created by Nick Treadway on 8/17/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

@interface FSMUser : NSManagedObject {
    
}

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *qr_code;
@property (nonatomic, retain) NSString *status;

@end
