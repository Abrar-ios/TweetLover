//
//  FavouriteTweetsManager.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "FavouriteTweetsManager.h"
#import "UserFavouriteTweets.h"
#import "TweetDataModel.h"

static FavouriteTweetsManager* sharedInstance = nil;

@implementation FavouriteTweetsManager

+ (FavouriteTweetsManager*)getSharedInstance{
    
    if (sharedInstance==nil) {
        sharedInstance = [[super alloc]init];
    }
    
    return sharedInstance;
}

- (void) toggleTweetStateWithTweetObj:(TweetDataModel*)twtDTO withMOC:(NSManagedObjectContext*)moc{
    
    if ([self checkDbContainsTweetInLocalDbWithTweetId:twtDTO.strTweetId withMOC:moc]) {
        [self removeTweetfromLocalDbWithTweetId:twtDTO.strTweetId withMOC:moc];
    }else{
        [self insertNewTweetInDBWithDict:twtDTO withMOC:moc];
    }
}

- (void)insertNewTweetInDBWithDict:(TweetDataModel*)twtDto withMOC:(NSManagedObjectContext*)moc{
    
    UserFavouriteTweets * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"UserFavouriteTweets"inManagedObjectContext:moc];
    
    newEntry.tweetId = twtDto.strTweetId;
    newEntry.tweet = twtDto.strTweetText;
    newEntry.name = twtDto.strUserName;
    newEntry.dpUrl = twtDto.strUserDpUrl;
    NSError *error;
    [moc save:&error];
}

- (void)removeTweetfromLocalDbWithTweetId:(NSString*)tweetId  withMOC:(NSManagedObjectContext*)moc{
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"UserFavouriteTweets"
                inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"tweetId=%@",tweetId];
    [fetchRequest setPredicate:pred];
    NSError *error;
    NSArray *items = [moc executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items){
        [moc deleteObject:managedObject];
        
    }
    
    [moc save:&error];
    
}

- (BOOL)checkDbContainsTweetInLocalDbWithTweetId:(NSString*)tweetId  withMOC:(NSManagedObjectContext*)moc{
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"UserFavouriteTweets"
                inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"tweetId=%@",tweetId];
    [fetchRequest setPredicate:pred];
    NSError *error;
    return [moc countForFetchRequest:fetchRequest error:&error];
    
}

- (NSArray*)fetchUserFavouriteTweetswithMOC:(NSManagedObjectContext*)moc
{
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"UserFavouriteTweets"
                inManagedObjectContext:moc];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
      NSError *error;
    return [moc executeFetchRequest:request error:&error];
}

@end
