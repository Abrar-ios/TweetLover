//
//  TweetFinderDataSourceAndDelegate.m
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "TweetFinderDataSourceAndDelegate.h"
#import "FavouriteTweetsManager.h"
#import "TweetTableViewCell.h"
#import "TweetDataModel.h"
#import "AppDelegate.h"

@interface TweetFinderDataSourceAndDelegate()

@property (nonatomic, weak) AppDelegate* appDelegate;
@property (nonatomic, weak) NSManagedObjectContext* manageObejctContext;

@end

@implementation TweetFinderDataSourceAndDelegate

- (id)init{
    
    if (self) {
        self = [super init];
        self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        self.manageObejctContext = [self.appDelegate managedObjectContext];
        self.userDpQueue= [[NSOperationQueue alloc]init];
        self.userDpQueue.maxConcurrentOperationCount = 5;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (self.arrayTweetsDS!=nil) {
        rows = self.arrayTweetsDS.count;
    }
    self.weakRefLabel.alpha = 0.0;
    if (rows ==0) {
        self.weakRefLabel.alpha = 1.0;
        self.weakRefLabel.text = @"Currently No Tweets here.";
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
    cell.weakRefUserDpQueue = self.userDpQueue;
    cell.weakRefTableView = self.weakReftblView;
    cell.delegateTweetStateHandler = self;
    TweetDataModel * tweetDto = (TweetDataModel*)[self.arrayTweetsDS objectAtIndex:indexPath.row];
    [cell renderTweetInCellWithTweetModel:tweetDto withIndexPath:indexPath withMOC:self.manageObejctContext];
    
    return cell;
}

#pragma PHandlerTweetState Implementation

- (void)toggleTweetStateWithIndex:(NSInteger)index{
    
    TweetDataModel* tweetDto = (TweetDataModel*)self.arrayTweetsDS[index];
    [[FavouriteTweetsManager getSharedInstance] toggleTweetStateWithTweetObj:tweetDto withMOC:self.manageObejctContext];
    [self.weakReftblView reloadData];
}

@end
