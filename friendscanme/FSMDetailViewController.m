//
//  FSMDetailViewController.m
//  friendscanme
//
//  Created by Nick Treadway on 8/16/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//
#import "FSMDetailViewController.h"
#import "FSMAppDelegate.h"
#import "FSMUser.h"
#import "FSMUsersSource.h"

@interface FSMDetailViewController ()

@property(nonatomic, strong) IBOutlet UILabel *userName;
@property(nonatomic, strong) IBOutlet UILabel *userUrl;
@property(retain, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;

@end

@implementation FSMDetailViewController

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
                 [self storeFBToken:user.id name:user.name];
             }
         }];
    } else {
        [self performSegueWithIdentifier:@"validSession" sender:self];
    }
          
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    self.userName = nil;
    self.userUrl = nil;
    self.userQrCode = nil;
    self.profilePictureView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)storeFBToken:(NSString *)token name:(NSString *)name {
    FSMUser *user = [[[FSMUser alloc] init] autorelease];
    user.fbID = token;
    user.name = name;
    FSMUsersSource *userSource = [[FSMUsersSource alloc] initWithFSMDetailViewController:self];
    [userSource sendRequest:user.fbID facebookName:user.name];
}


@end
