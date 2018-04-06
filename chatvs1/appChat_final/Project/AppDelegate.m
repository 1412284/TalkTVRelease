//
//  AppDelegate.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageDetail.h"
#import "Date.h"
@interface AppDelegate ()
@property (strong, nonatomic,nullable) NSArray *ListtoSenderID;
@end

@implementation AppDelegate
@synthesize timer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _dbMessages = [[DBMessages alloc] initWithDatabaseFilename:@"database.sqlite"];
     _dbTopic = [[DBTopic alloc] initWithDatabaseFilename:@"database.sqlite"];
    _ListtoSenderID = @[@"system",@"54",@"3655",@"78878",@"24"];
    _dataMessages = [[NSMutableArray  alloc] init];
   [self startTimedTask];
    return YES;
}
- (void)startTimedTask
{
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
}

- (void)performBackgroundTask
{
    //[self.delegate SentMessages];
    NSLog(@"Hello World!");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@" message send.......:  %@ ", @"hihi");
        int i = arc4random()%5;
        NSString *toSenderID = _ListtoSenderID[i];
        NSDate* timeMessages = [NSDate date];
        NSString *dateDisplay = [Date stringFormDate:timeMessages];
        NSString *messagesID = [MessageDetail createMessagesID:timeMessages senderID:toSenderID];
        //NSLog(@"time masages = %@    %@",dateDisplay, messagesID);
        NSString *contentMessages = @"hihi";
        NSString *topicID = [@"1000liem6396" stringByAppendingString:toSenderID];
        MessageDetail *new = [MessageDetail init:messagesID topicID:topicID type:3 senderID:toSenderID toSenderID:@"1000liem6396" nameSenderID:@"N/a" avatarURLSenderID:@"N/A" action:@"N/A" timeMessages:dateDisplay title:@"N/A" stateSeen:0 contentMessages:contentMessages];
        NSLog(@"%@",new);
        [DBMessages executeQueryInsert:new dbMessages:self.dbMessages];
        [DBTopic UpdateTopic:self.dataMessages dbMessages:self.dbMessages dbTopic:self.dbTopic senderID:@"1000liem6396" toSenderID:toSenderID];
        [DBTopic UpdateContentTopicUnfollow:self.dbTopic senderID:@"1000liem6396"];
        //Do background work
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.delegate SentMessages:new];
     //[GlobalData sharedGlobalData].message = @"1";
            //Update UI
            //NSLog(@"Hello World!,  %@",[GlobalData sharedGlobalData].message);
        });
    });
}

//define the target method

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Me is here at 1 minute delay");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
