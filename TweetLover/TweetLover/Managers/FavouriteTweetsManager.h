//
//  FavouriteTweetsManager.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TweetDataModel;

@interface FavouriteTweetsManager : NSObject

+ (FavouriteTweetsManager*)getSharedInstance;

- (NSArray*)fetchUserFavouriteTweetswithMOC:(NSManagedObjectContext*)moc;
- (void) toggleTweetStateWithTweetObj:(TweetDataModel*)twtDTO withMOC:(NSManagedObjectContext*)moc;
- (void)insertNewTweetInDBWithDict:(TweetDataModel*)twtDto withMOC:(NSManagedObjectContext*)moc;
- (void)removeTweetfromLocalDbWithTweetId:(NSString*)tweetId  withMOC:(NSManagedObjectContext*)moc;
- (BOOL)checkDbContainsTweetInLocalDbWithTweetId:(NSString*)tweetId  withMOC:(NSManagedObjectContext*)moc;

@end
