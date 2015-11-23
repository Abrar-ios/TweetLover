//
//  UserFavouriteTweets+CoreDataProperties.h
//  TweetLover
//
//  Created by Abrar  Ul Haq on 23/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserFavouriteTweets.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserFavouriteTweets (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *dpUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *tweet;
@property (nullable, nonatomic, retain) NSString *tweetId;

@end

NS_ASSUME_NONNULL_END
