//
//  TweetDataModel.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "TweetDataModel.h"


@implementation TweetDataModel

@synthesize imgUserDp;
@synthesize strUserDpUrl;
@synthesize strUserName;
@synthesize strTweetText;
@synthesize strTweetId;


- (NSArray*)renderTweetsWithArrayOfTweets:(NSArray*)arrTweets{
    
    NSInteger loopCount = arrTweets.count;
    NSMutableArray* arrayOfTweets = [[NSMutableArray alloc]init];

    for ( int index = 0; index < loopCount; index++) {
        
        NSDictionary * indexedDict = (NSDictionary*)arrTweets[index];
        TweetDataModel * twtDto = [[TweetDataModel alloc]init];
        twtDto.strTweetText = [indexedDict objectForKey:@"text"];
        twtDto.strTweetId = [indexedDict objectForKey:@"id_str"];
        NSDictionary* usrDict = [indexedDict objectForKey:@"user"];
        twtDto.strUserName = [usrDict objectForKey:@"screen_name"];
        twtDto.strUserDpUrl = [usrDict objectForKey:@"profile_image_url"];
        
        [arrayOfTweets addObject:twtDto];
        
    }
    
    return arrayOfTweets;
    
}



@end
