//
//  PLiveTweetsRenderHandler.h
//  TweetFinder
//
//  Created by Abrar  Ul Haq on 20/11/2015.
//  Copyright © 2015 Abrar  Ul Haq. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PLiveTweetsRenderHandler <NSObject>

- (void)renderTweetsOnScreenOnSuccessfulTweetRequest;
- (void)reloadTweetsOnCancelRequest;

@end
