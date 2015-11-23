//
//  FavouriteTweetsDataSourceAndDelegate.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "FavouriteTweetsDataSourceAndDelegate.h"
#import "FavouriteTweetsManager.h"
#import "TweetTableViewCell.h"
#import "UserFavouriteTweets.h"
#import "TweetDataModel.h"
#import "AppDelegate.h"

@interface FavouriteTweetsDataSourceAndDelegate()

@property (nonatomic, strong) AppDelegate* appDelegate;
@property (nonatomic, strong) NSManagedObjectContext* manageObejctContext;

@end

@implementation FavouriteTweetsDataSourceAndDelegate

- (id)init{
    
    if (self) {
        self = [super init];
        self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        self.manageObejctContext = [self.appDelegate managedObjectContext];
        self.usrsDpQueue= [[NSOperationQueue alloc]init];
        self.usrsDpQueue.maxConcurrentOperationCount = 5;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (self.arrayFavTweetsDS!=nil) {
        rows = self.arrayFavTweetsDS.count;
    }
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"TweetTableViewCell";
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TweetTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.weakRefUserDpQueue = self.usrsDpQueue;
    cell.weakRefTableView = self.weakReftblView;
    cell.delegateTweetStateHandler = self;
    UserFavouriteTweets * tweetDto = (UserFavouriteTweets*)[self.arrayFavTweetsDS objectAtIndex:indexPath.row];
    [cell renderFavouriteTweetInCellWithTweetModel:tweetDto withIndexPath:indexPath withMOC:self.manageObejctContext];
    
    return cell;
}

#pragma PHandlerTweetState Implementation

- (void)toggleTweetStateWithIndex:(NSInteger)index{
    
    UserFavouriteTweets* tweetDto = (UserFavouriteTweets*)self.arrayFavTweetsDS[index];
    [[FavouriteTweetsManager getSharedInstance] removeTweetfromLocalDbWithTweetId:tweetDto.tweetId withMOC:self.manageObejctContext];
    [self.arrayFavTweetsDS removeObjectAtIndex:index];
    [self.weakReftblView reloadData];
}

@end
