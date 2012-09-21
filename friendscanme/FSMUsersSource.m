//
//  FSMUsersSource.m
//  friendscanme
//
//  Created by Nick Treadway on 9/6/12.
//  Copyright (c) 2012 Yeti Media. All rights reserved.
//
#import "FSMUsersSource.h"
#import "FSMUser.h"
#import "FSMDetailViewController.h"

@interface FSMUsersSource()

@property(strong, nonatomic) NSString *FSMtoken;
@property(nonatomic,assign)FSMDetailViewController *detailsView;

@end

@implementation FSMUsersSource

@synthesize FSMtoken = _FSMtoken;
@synthesize detailsView = _detailsView;

- (id)initWithFSMDetailViewController:(FSMDetailViewController*)vc {
    self = [super init];
    if (self) {
        self.detailsView = vc;
    }
    return self;
}


- (void)sendRequest:(NSString *)facebookID facebookName:(NSString *)name {
    
    self.FSMtoken = @"90bbf880f9dd2ec3459cb47d1feb67bc";
    RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://friendscan.me/api/v1"];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"facebook", @"auth[provider]",
                              facebookID, @"auth[uid]",
                              name, @"auth[info][name]",
                              nil];
    
    

    
    RKObjectManager* objectManager =[RKObjectManager objectManagerWithBaseURL:baseURL];
    [RKObjectManager setSharedManager:objectManager];
    objectManager.client.baseURL = baseURL;
    [[objectManager client] setValue:self.FSMtoken forHTTPHeaderField:@"X-Access-Token"];
    
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"FSM.sqlite"];
    objectManager.objectStore = objectStore;
    RKManagedObjectMapping *mapper = [RKManagedObjectMapping mappingForClass:[FSMUser class] inManagedObjectStore:objectManager.objectStore];
    [mapper mapKeyPath:@"user_id" toAttribute:@"user_id"];
    [mapper mapKeyPath:@"qr_code" toAttribute:@"qr_code"];
    [mapper mapKeyPath:@"status" toAttribute:@"status"];
    
    [self fetchObject];
    
    FSMUser *card = nil;

    if (![_card count]==0) {
        card = [_card objectAtIndex:0];
    }
    
    if (!card.user_id) {
        [objectManager loadObjectsAtResourcePath:@"/authentication"usingBlock:^(RKObjectLoader* loader) {
            loader.method = RKRequestMethodPOST;
            loader.params = params;
            loader.delegate = self;
            loader.objectMapping = mapper;
            }
         ];
    
    } else {
        [self loadQRcode:card];
    }

    
}


- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    
    [self fetchObject];
    FSMUser *card = [_card objectAtIndex:0];
    [self loadQRcode:card];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)loadQRcode:(FSMUser *)card {
    
    NSURL *url = [NSURL URLWithString:card.qr_code];
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    [_detailsView.userQrCode setImage:image];
    [self releaseClass];
    
}

- (void)releaseClass   {
  self.FSMtoken = nil;
  [self autorelease];
  [_card release];
}

- (id)fetchObject {
    
    [_card release];
    NSFetchRequest *request = [FSMUser fetchRequest];
    _card = [[FSMUser objectsWithFetchRequest:request] retain];
    return _card;
}

@end
