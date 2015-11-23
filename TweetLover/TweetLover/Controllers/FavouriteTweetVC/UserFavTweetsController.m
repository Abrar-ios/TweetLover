//
//  SecondViewController.m
//  TweetLover
//
//  Created by Abrar  Ul Haq on 23/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "AppDelegate.h"
#import "FavouriteTweetsManager.h"
#import "UserFavTweetsController.h"
#import "FavouriteTweetsDataSourceAndDelegate.h"

@interface UserFavTweetsController ()

@property (nonatomic, weak) IBOutlet UITableView* tblFavTweets;

@property (nonatomic, strong) NSMutableArray* arrayFavTweets;
@property (nonatomic, weak) AppDelegate* appDelegate;
@property (nonatomic, weak) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) FavouriteTweetsDataSourceAndDelegate* dataSourceAndDelegateFavTweet;

@end

@implementation UserFavTweetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    self.dataSourceAndDelegateFavTweet = [[FavouriteTweetsDataSourceAndDelegate alloc]init];
    self.tblFavTweets.dataSource = self.dataSourceAndDelegateFavTweet;
    self.tblFavTweets.delegate = self.dataSourceAndDelegateFavTweet;
    self.dataSourceAndDelegateFavTweet.arrayFavTweetsDS = self.arrayFavTweets;
    self.dataSourceAndDelegateFavTweet.weakReftblView = self.tblFavTweets;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self getUserFavouriteTweets];
}

- (void)getUserFavouriteTweets{
    
    self.arrayFavTweets = [[FavouriteTweetsManager getSharedInstance] fetchUserFavouriteTweetswithMOC:self.managedObjectContext];
    self.dataSourceAndDelegateFavTweet.arrayFavTweetsDS = self.arrayFavTweets;
    [self.tblFavTweets reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
