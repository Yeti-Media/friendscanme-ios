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
        NSLog(@"called %@", vc);
    }
    return self;
}


- (void)sendRequest:(NSString *)facebookID facebookName:(NSString *)name {
      self.FSMtoken = @"90bbf880f9dd2ec3459cb47d1feb67bc";
      RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://my.local:3000/api/v1"];
      RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
      objectManager.client.baseURL = baseURL;
      [[objectManager client] setValue:self.FSMtoken forHTTPHeaderField:@"X-Access-Token"];
   
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"facebook", @"auth[provider]",
                            facebookID, @"auth[uid]",
                            name, @"auth[info][name]",
                            nil];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/authentication" usingBlock:^(RKObjectLoader* loader) {
        loader.method = RKRequestMethodPOST;
        loader.params = params;
        loader.delegate = self;
        loader.objectMapping = [RKObjectMapping mappingForClass:[FSMUser class] usingBlock:^(RKObjectMapping *mapping)
                                {
                                  [mapping mapKeyPath:@"user_id" toAttribute:@"fsmID"];
                                  [mapping mapKeyPath:@"qr_code" toAttribute:@"qrcode"];
                                }];
    }];

}


- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    FSMUser *card = [objects objectAtIndex:0];
    NSLog(@"Loaded Contact ID #%@ -> Name: %@, Code: %@", card.fsmID, card.name, card.qrcode);
    self.FSMtoken = nil;
    [self loadQRcode:card];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

-(void)loadQRcode:(FSMUser *)card {
    NSURL *url = [NSURL URLWithString:card.qrcode];
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    card.qrcodeImage = image;
    
    [_detailsView.userQrCode setImage:card.qrcodeImage];
    [self releaseClass];
    
}

-(void)releaseClass   {
  self.FSMtoken = nil;
  [self autorelease];
}

@end
