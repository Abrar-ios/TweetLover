//
//  LiveTweetsManager.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "LiveTweetsManager.h"
#import "TweetDataModel.h"

static NSString* const StrTweetsLimit = @"100";
static NSString* const StrTweetsApiUrl = @"https://api.twitter.com/1.1/search/tweets.json";
static LiveTweetsManager* mgrLiveTweetsInstance = nil;
static NSArray* arrayTweets = nil;

@interface LiveTweetsManager()

@property (nonatomic, strong) TweetDataModel* twtDto;

@end

@implementation LiveTweetsManager

@synthesize twtDto;
@synthesize delegateLiveTweetsRenderer;


+ (LiveTweetsManager*)getSharedInstance{
    
    if (mgrLiveTweetsInstance==nil) {
        mgrLiveTweetsInstance = [[super alloc]init];
    }
    
    return mgrLiveTweetsInstance;
    
}

- (id)init{
    
    if (self) {
        self = [super init];
        self.twtDto = [[TweetDataModel alloc]init];
    }
    
    return self;
}

- (void)getUsersTweetsWithSearchingParam:(NSString*)strSearch{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:StrTweetsApiUrl] parameters:[NSDictionary dictionaryWithObjectsAndKeys:strSearch,@"q",StrTweetsLimit,@"rpp", nil]];
                [twitterInfoRequest setAccount:twitterAccount];
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"limit reached");
                            return;
                        }
                        
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        
                        if (responseData) {
                            
                            NSError *error = nil;
                          NSDictionary* responseDict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
                            [self renderTweetsWithReponceDict:responseDict];
                            
                        }
                    });
                }];
            }
        } else {
            NSLog(@"No access granted by User");
        }
    }];
    
}


- (void)renderTweetsWithReponceDict:(NSDictionary*)resDictObj{
    
    NSArray* arrayTweets = [resDictObj objectForKey:@"statuses"];
    if (arrayTweets!=nil) {
        
        arrayTweets = [self.twtDto renderTweetsWithArrayOfTweets:arrayTweets];
        [LiveTweetsManager setUsersTweetsWithArray:arrayTweets];
        [self.delegateLiveTweetsRenderer renderTweetsOnScreenOnSuccessfulTweetRequest];
    }
    
    
}


+ (NSArray*)getUsersTweets{
    
    return arrayTweets;
}

+ (void)setUsersTweetsWithArray:(NSArray*)arrTweets{
    
    arrayTweets = arrTweets;
}


@end
