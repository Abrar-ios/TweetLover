//
//  TweetFinderTableViewCell.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "PHandlerTweetState.h"
@class TweetDataModel;
@class UserFavouriteTweets;

@interface TweetTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* lblTweet;
@property (nonatomic, weak) IBOutlet UILabel* lblUserName;

@property (nonatomic, weak) UITableView* weakRefTableView;
@property (nonatomic, weak) IBOutlet UIButton* btnMakeFav;
@property (nonatomic, weak) IBOutlet UIImageView* imgBtnFav;
@property (nonatomic, weak) IBOutlet AsyncImageView* imgUserProfile;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* actProgressView;

@property (nonatomic, weak) NSOperationQueue* weakRefUserDpQueue;
@property (nonatomic, weak) id<PHandlerTweetState> delegateTweetStateHandler;


- (void)renderTweetInCellWithTweetModel:(TweetDataModel*)tweetDto withIndexPath:(NSIndexPath*)indexed withMOC:(NSManagedObjectContext*)moc;
- (void)renderFavouriteTweetInCellWithTweetModel:(UserFavouriteTweets*)tweetDto withIndexPath:(NSIndexPath*)indexed withMOC:(NSManagedObjectContext*)moc;

@end
