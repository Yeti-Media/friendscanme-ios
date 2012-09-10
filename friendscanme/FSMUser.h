//
//  FSMUser.h
//  friendscanme
//
//  Created by Nick Treadway on 8/17/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSMUser : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *fbID;
@property(nonatomic, copy) NSString *qrcode;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *fsmID;
@property(nonatomic, retain) UIImage *qrcodeImage;

@end
