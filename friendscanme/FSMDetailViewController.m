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

@interface FSMDetailViewController ()

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
    
     FSMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    
    if (appDelegate.session.isOpen) {
        NSLog(@"your super fucked"); 
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,
                                       NSDictionary<FBGraphUser> *user,
                                       NSError *error) {
     
     
         if(!error){
             _profilePictureView.profileID = user.id;
            NSLog(@"%@", user.id); 
         }
     }];
    } else {
        NSLog(@"your fucked"); 
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
