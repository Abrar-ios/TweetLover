//
//  FirstViewController.m
//  TweetLover
//
//  Created by Abrar  Ul Haq on 23/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import "TweetSearchController.h"
#import "LiveTweetsManager.h"
#import "TweetFinderDataSourceAndDelegate.h"

@interface TweetSearchController ()

@property (nonatomic, weak) IBOutlet UIView* viewProgressCont;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* actProgressView;
@property (nonatomic, weak) IBOutlet UILabel* lblNoRecord;
@property (nonatomic, weak) IBOutlet UISearchBar* searchBar;
@property (nonatomic, weak) IBOutlet UITableView* tblUserTweets;
@property (nonatomic, strong) NSArray* arrayTweetsSource;
@property (nonatomic, strong) TweetFinderDataSourceAndDelegate* dataSourceAndDelegateTweets;

@end

@implementation TweetSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.searchBar.backgroundImage = nil;
    self.searchBar.backgroundColor = [UIColor clearColor];
    [LiveTweetsManager getSharedInstance].delegateLiveTweetsRenderer = self;
    self.dataSourceAndDelegateTweets = [[TweetFinderDataSourceAndDelegate alloc]init];
    self.tblUserTweets.dataSource = self.dataSourceAndDelegateTweets;
    self.tblUserTweets.delegate = self.dataSourceAndDelegateTweets;
    self.dataSourceAndDelegateTweets.arrayTweetsDS = self.arrayTweetsSource;
    self.dataSourceAndDelegateTweets.weakReftblView = self.tblUserTweets;
    self.dataSourceAndDelegateTweets.weakRefLabel = self.lblNoRecord;
    self.viewProgressCont.alpha = 0.0;
    [self.actProgressView stopAnimating];
    self.lblNoRecord.text = @"Currently No Tweets here.";
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma PLiveTweetsRenderHandler Implementation

- (void)reloadTweetsOnCancelRequest{
    self.dataSourceAndDelegateTweets.arrayTweetsDS = nil;
    [self.tblUserTweets reloadData];
}

- (void)renderTweetsOnScreenOnSuccessfulTweetRequest{
    
    [UIView animateWithDuration:.15f animations:^{
        [self.actProgressView stopAnimating];
        self.viewProgressCont.alpha = 0.0;
    }];
   
    self.arrayTweetsSource = [LiveTweetsManager getUsersTweets];
    self.dataSourceAndDelegateTweets.arrayTweetsDS = self.arrayTweetsSource;
    [self.tblUserTweets reloadData];
}


#pragma UISearchBarDelegate Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self reloadTweetsOnCancelRequest];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
  if (searchBar.text.length!=0){
      [UIView animateWithDuration:.15f animations:^{
          self.lblNoRecord.alpha = 0.0;
          self.viewProgressCont.alpha = 1.0;
      }];
      
      [self.actProgressView startAnimating];
        [searchBar setShowsCancelButton:NO animated:YES];
        [[LiveTweetsManager getSharedInstance] getUsersTweetsWithSearchingParam:searchBar.text];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
