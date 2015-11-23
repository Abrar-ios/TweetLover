//
//  FavouriteTweetsDataSourceAndDelegate.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHandlerTweetState.h"
@interface FavouriteTweetsDataSourceAndDelegate : NSObject<UITableViewDataSource, UITableViewDelegate,PHandlerTweetState>

@property (nonatomic, strong) NSOperationQueue* usrsDpQueue;
@property (nonatomic, weak) NSMutableArray* arrayFavTweetsDS;
@property (nonatomic, weak) UITableView* weakReftblView;

@end
