//
//  TweetFinderDataSourceAndDelegate.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHandlerTweetState.h"

@interface TweetFinderDataSourceAndDelegate : NSObject<UITableViewDataSource, UITableViewDelegate,PHandlerTweetState>

@property (nonatomic, weak) UILabel* weakRefLabel;
@property (nonatomic, strong) NSOperationQueue* userDpQueue;
@property (nonatomic, weak) NSArray* arrayTweetsDS;
@property (nonatomic, weak) UITableView* weakReftblView;

@end
