//
//  TweetFinderTableViewCell.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//


#import "TweetTableViewCell.h"
#import "TweetDataModel.h"
#import "FavouriteTweetsManager.h"
#import "UserFavouriteTweets.h"

static NSString* const arrayAddRemoveFavourite[] = {
    @"UnFavourite",
    @"Favourite"};

@implementation TweetTableViewCell

@synthesize weakRefUserDpQueue;
@synthesize actProgressView;
@synthesize imgUserProfile;
@synthesize lblUserName;
@synthesize lblTweet;
@synthesize imgBtnFav;
@synthesize btnMakeFav;

- (void)awakeFromNib {
    
    self.imgUserProfile.layer.cornerRadius = self.imgUserProfile.frame.size.height /2;
    self.imgUserProfile.layer.masksToBounds = YES;
    self.imgUserProfile.layer.borderWidth = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderTweetInCellWithTweetModel:(TweetDataModel*)tweetDto withIndexPath:(NSIndexPath*)indexed withMOC:(NSManagedObjectContext*)moc{
    
    self.lblUserName.text = tweetDto.strUserName;
    self.lblTweet.text = tweetDto.strTweetText;
    self.btnMakeFav.tag = indexed.row;
    //Here we need to asynchronously download the books cover image...
    NSString *urlUserDp = tweetDto.strUserDpUrl;
    NSInteger isFavourite =(NSInteger) [[FavouriteTweetsManager getSharedInstance] checkDbContainsTweetInLocalDbWithTweetId:tweetDto.strTweetId withMOC:moc];
    self.imgBtnFav.image = [UIImage imageNamed:(NSString*)arrayAddRemoveFavourite[isFavourite]];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSIndexPath* localIndexPath = [NSIndexPath indexPathForItem:indexed.item inSection:indexed.section];
        NSData *dataCoverImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlUserDp]];
        tweetDto.imgUserDp = [UIImage imageWithData:dataCoverImg];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.weakRefTableView.indexPathsForVisibleRows containsObject:localIndexPath])
            {
                __weak TweetTableViewCell *cell =
                (TweetTableViewCell *)[self.weakRefTableView cellForRowAtIndexPath:localIndexPath];
                cell.imgUserProfile.imageURL = [NSURL URLWithString:urlUserDp];
                
            }
            
        });
    }];
    
    operation.queuePriority = NSOperationQueuePriorityHigh;
    [self.weakRefUserDpQueue addOperation:operation];
    
}

- (void)renderFavouriteTweetInCellWithTweetModel:(UserFavouriteTweets*)tweetDto withIndexPath:(NSIndexPath*)indexed withMOC:(NSManagedObjectContext*)moc{
    
    self.lblUserName.text = tweetDto.name;
    self.lblTweet.text = tweetDto.tweet;
    self.btnMakeFav.tag = indexed.row;
    //Here we need to asynchronously download the books cover image...
    NSString *urlUserDp = tweetDto.dpUrl;
    self.imgBtnFav.image = [UIImage imageNamed:(NSString*)arrayAddRemoveFavourite[1]];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSIndexPath* localIndexPath = [NSIndexPath indexPathForItem:indexed.item inSection:indexed.section];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.weakRefTableView.indexPathsForVisibleRows containsObject:localIndexPath])
            {
                __weak TweetTableViewCell *cell =
                (TweetTableViewCell *)[self.weakRefTableView cellForRowAtIndexPath:localIndexPath];
                cell.imgUserProfile.imageURL = [NSURL URLWithString:urlUserDp];
                
            }
            
        });
    }];
    
    operation.queuePriority = NSOperationQueuePriorityHigh;
    [self.weakRefUserDpQueue addOperation:operation];
    
}



- (IBAction)btnFavouritePressed:(id)sender{
   
    UIButton* btnFav = (UIButton*)sender;
    [self.delegateTweetStateHandler toggleTweetStateWithIndex:btnFav.tag];
    
}

@end
