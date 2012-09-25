//
//  FSMViewController.m
//  friendscanme
//
//  Created by Nick Treadway on 8/21/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//

#import "FSMViewController.h"
#import "FSMAppDelegate.h"

@interface FSMViewController ()

@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)authButtonAction:(id)sender;

@end

@implementation FSMViewController

@synthesize buttonLogin = _buttonLogin;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    FSMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    if (FBSession.activeSession.isOpen) {
        self.buttonLogin.hidden = true;
    } else {
        self.buttonLogin.hidden = false;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.buttonLogin = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)authButtonAction:(id)sender {
    FSMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [appDelegate openSessionWithAllowLoginUI:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    if (FBSession.activeSession.isOpen) {
        sleep(1.0);
        
        [self performSegueWithIdentifier:@"validSession" sender:self];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        self.buttonLogin.hidden = true;
        [self performSegueWithIdentifier:@"validSession" sender:self];
    } else {
        self.buttonLogin.hidden = false;
    }
}

@end
