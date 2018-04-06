//
//  ListTopicViewController.h
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "DBTopic.h"
#import  "AppDelegate.h"

@interface ListTopicViewController : UIViewController<EventListener>

//@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) NSMutableArray *dataTopicUnfollow;
@property (strong, nonatomic) NSMutableArray *dataTopic;
@property DBTopic *dbTopic;
//@property (strong, nonatomic) NSArray *dataTopic;
//@property (strong, nonatomic) IBOutlet UIView *statusbarview;
@property (nonatomic, retain) NSTimer * time_update;

@end
