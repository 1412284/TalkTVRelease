//
//  AppDelegate.h
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalData.h"
#import "DBMessages.h"
#import "DBTopic.h"
@protocol EventListener <NSObject>
- (void)SentMessages:(MessageDetail*_Nullable)newMessages;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, retain) IBOutlet id<EventListener> delegate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSTimer * timer;
@property DBMessages * _Nonnull dbMessages;
@property DBTopic * _Nonnull dbTopic;
@property (strong, nonatomic,nullable) NSMutableArray *dataMessages;

@end

