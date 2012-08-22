//
//  FSMUser.m
//  friendscanme
//
//  Created by Nick Treadway on 8/17/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import "FSMUser.h"

@implementation FSMUser

@synthesize name = _name;
@synthesize url = _url;
@synthesize qrcode = _qrcode;
@synthesize thumb = _thumb;


- (id)init {
    self = [super init];
    if (self) {
        self.name = @"Yeti";
        self.url = @"http:://friendscan.me";
    }
    return self;
}


@end
