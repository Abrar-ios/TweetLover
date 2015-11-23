//
//  LiveTweetsManager.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLiveTweetsRenderHandler.h"

@interface LiveTweetsManager : NSObject

@property (nonatomic, weak) id<PLiveTweetsRenderHandler> delegateLiveTweetsRenderer;

+ (LiveTweetsManager*)getSharedInstance;

+ (NSArray*)getUsersTweets;
+ (void)setUsersTweetsWithArray:(NSArray*)arrTweets;
- (void)getUsersTweetsWithSearchingParam:(NSString*)strSearch;

@end
