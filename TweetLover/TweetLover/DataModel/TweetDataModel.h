//
//  TweetDataModel.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetDataModel : NSObject

@property (nonatomic, copy) NSString* strTweetId;
@property (nonatomic, copy) NSString* strUserName;
@property (nonatomic, copy) NSString* strTweetText;
@property (nonatomic, copy) NSString* strUserDpUrl;
@property (nonatomic, strong) UIImage* imgUserDp;

- (NSArray*)renderTweetsWithArrayOfTweets:(NSArray*)arrTweets;

@end
