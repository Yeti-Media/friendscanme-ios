//
//  FSMDetailViewController.m
//  friendscanme
//
//  Created by Nick Treadway on 8/16/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FSMDetailViewController.h"
#import "FSMAppDelegate.h"
#import "FSMUser.h"

@interface FSMDetailViewController ()

@property(nonatomic, strong) IBOutlet UILabel *userName;
@property(nonatomic, strong) IBOutlet UILabel *userUrl;
@property(nonatomic, strong) IBOutlet UIImageView *userQrCode;
@property(retain, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property(nonatomic, strong) FSMUser *user;

@end

@implementation FSMDetailViewController

@synthesize user = _user;
@synthesize userName = _userName;
@synthesize userUrl = _userUrl;
@synthesize userQrCode = _userQrCode;
@synthesize profilePictureView = _profilePictureView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if (FBSession.activeSession.isOpen) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             
             if(!error){
                 _profilePictureView.profileID = user.id;
                 self.userName.text =  user.name;
             }
         }];
    } else {
        [self performSegueWithIdentifier:@"validSession" sender:self];
    }
    
            
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.user = nil;
    self.userName = nil;
    self.userUrl = nil;
    self.userQrCode = nil;
    _profilePictureView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
