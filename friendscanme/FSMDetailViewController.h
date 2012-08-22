//
//  FSMDetailViewController.h
//  friendscanme
//
//  Created by Nick Treadway on 8/16/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FSMUser.h"

@interface FSMDetailViewController : UIViewController


//@property (retain, nonatomic) IBOutlet UIView *profilePictureOuterView;

@property(nonatomic, strong) IBOutlet UILabel *userName;
@property(nonatomic, strong) IBOutlet UILabel *userUrl;
@property(nonatomic, strong) IBOutlet UIImageView *userQrCode;
@property(retain, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property(nonatomic, strong) FSMUser *user;

@end
