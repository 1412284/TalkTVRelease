//
//  DataCenter.m
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "DataCenter.h"
#import "Topic.h"
#import "NSDate+NVTimeAgo.h"
#import  "MessageCollectionViewCell.h"

@implementation DataCenter

static DataCenter* _shareDataCenter = nil;
+(DataCenter*)shareDataCenter
{
    @synchronized([DataCenter class])
    {
        if (!_shareDataCenter)
            _shareDataCenter = [[self alloc] init];
        
        return _shareDataCenter;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([DataCenter class])
    {
        _shareDataCenter = [super alloc];
        return _shareDataCenter;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        
        // initialize stuff here
    }
    
    return self;
}

-(void)getMessage {
    
}
-(NSMutableArray*)getListTimeTopic {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:@"2018-01-16 11:00:00"];
    [arr addObject:@"2018-01-16 05:00:00"];
    [arr addObject:@"2018-01-15 10:00:00"];
    [arr addObject:@"2018-01-14 10:00:00"];
    [arr addObject:@"2018-01-13 10:01:00"];
    [arr addObject:@"2018-01-12 10:02:00"];
    [arr addObject:@"2018-01-11 10:03:07"];
    [arr addObject:@"2018-01-10 16:00:00"];
    [arr addObject:@"2017-12-15 10:10:00"];
    [arr addObject:@"2016-12-15 12:25:05"];
    return arr;
}

-(NSMutableArray*)getListTopic {
   // NSMutableArray *arrTime = [self getListTimeTopic];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray*listName = [NSArray arrayWithObjects: @"System Notification", @"Idol Group", @"Meg Griffin", @"Jack Lolwut",
     @"Mike Roflcoptor", @"Cindy Woods", @"Jessica Windmill", @"Alexander The Great",
     @"Sarah Peterson", @"Scott Scottland", @"Geoff Fanta", @"Amanda Pope", @"Michael Meyers",
     @"Richard Biggus", @"Montey Python", @"Mike Wut", @"Fake Person", @"Chair",
     nil];
//    for(int i = 0; i<10; i++)
//    {
        Topic*topic = [[Topic alloc] init];
        topic.avatar = @"idol_profile";
        topic.title = [listName objectAtIndex:0];
        //topic.time = arrTime[1];
        topic.time = @"2018-03-09 1:00:01";
        topic.subTitle = @"Hello, nice to meet you ...";
        topic.type = 0;
        topic.newMesage =YES;
        topic.unfollow = NO;
        [arr addObject:topic];
   // }
    return arr;
}


-(NSMutableArray*)getMoreListTopic {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSArray*listName = [NSArray arrayWithObjects: @"System Notification", @"Idol Group", @"Meg Griffin", @"Jack Lolwut",
                        @"Mike Roflcoptor", @"Cindy Woods", @"Jessica Windmill", @"Alexander The Great",
                        @"Sarah Peterson", @"Scott Scottland", @"Geoff Fanta", @"Amanda Pope", @"Michael Meyers",
                        @"Richard Biggus", @"Montey Python", @"Mike Wut", @"Fake Person", @"Chair",
                        nil];
    for(int i = 0; i<10; i++)
    {
        Topic*topic = [[Topic alloc] init];
        topic.avatar = @"idol_profile";
        topic.title = [listName objectAtIndex:i];
        topic.time = @"2018-01-11 10:00:00";
        topic.subTitle = @"Hello, nice to meet you ...";
        topic.type = 2;
        topic.newMesage = (i%2==0)?YES:NO;
        topic.unfollow = NO;
        [arr addObject:topic];
    }
    return arr;
}

-(NSMutableArray*)getListUnfollow {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray*listName = [NSArray arrayWithObjects: @"Montey Python", @"Fake Person", @"Meg Griffin", @"Jack Lolwut",
                        @"Mike Roflcoptor", @"Cindy Woods", @"Jessica Windmill", @"Alexander The Great",
                        @"Sarah Peterson", @"Scott Scottland", @"Geoff Fanta", @"Amanda Pope", @"Michael Meyers",
                        @"Richard Biggus", @"Montey Python", @"Mike Wut", @"Fake Person", @"Chair",
                        nil];
    for(int i = 0; i<10; i++)
    {
        Topic*topic = [[Topic alloc] init];
        topic.avatar = @"idol_profile";
        topic.title = [listName objectAtIndex:i];
        topic.time = @"19:45";
        topic.subTitle = @"Hello, nice to meet you ...";
        topic.type = 2;
        topic.newMesage = (i%2==0)?YES:NO;
        topic.unfollow = YES;
        [arr addObject:topic];
    }
    return arr;
}
-(NSMutableArray*)getListMoreTimeMessage {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:@"2016-10-10 10:00:00"];
    [arr addObject:@"2016-10-11 10:00:00"];
    [arr addObject:@"2016-10-14 10:00:00"];
    [arr addObject:@"2016-10-15 10:00:00"];
    [arr addObject:@"2016-10-15 10:01:00"];
    [arr addObject:@"2016-10-15 10:02:00"];
    [arr addObject:@"2016-10-15 10:03:07"];
    [arr addObject:@"2016-10-15 16:00:00"];
    [arr addObject:@"2016-10-15 16:30:00"];
    [arr addObject:@"2016-10-15 16:40:00"];
    [arr addObject:@"2016-11-15 07:08:00"];
    [arr addObject:@"2016-11-15 09:08:09"];
    [arr addObject:@"2016-11-15 10:00:00"];
    [arr addObject:@"2016-12-15 10:10:00"];
    [arr addObject:@"2016-12-15 12:25:05"];
    [arr addObject:@"2016-12-15 16:54:15"];
    [arr addObject:@"2016-12-15 17:00:00"];
    [arr addObject:@"2016-12-15 14:00:00"];
    [arr addObject:@"2017-01-15 06:59:00"];
    [arr addObject:@"2017-01-15 07:00:00"];
    [arr addObject:@"2017-01-15 09:00:00"];
    [arr addObject:@"2017-01-15 09:40:00"];
    [arr addObject:@"2017-01-15 10:00:00"];
    [arr addObject:@"2017-01-16 05:03:01"];
    [arr addObject:@"2017-01-16 05:04:01"];
    [arr addObject:@"2017-01-16 06:00:01"];
    [arr addObject:@"2017-01-16 09:00:01"];
    return arr;
}
-(NSMutableArray*)getListTimeMessage {
     NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:@"2017-10-10 10:00:00"];
    [arr addObject:@"2017-10-11 10:00:00"];
    [arr addObject:@"2017-10-14 10:00:00"];
    [arr addObject:@"2017-10-15 10:00:00"];
    [arr addObject:@"2017-10-15 10:01:00"];
    [arr addObject:@"2017-10-15 10:02:00"];
    [arr addObject:@"2017-10-15 10:03:07"];
    [arr addObject:@"2017-10-15 16:00:00"];
    [arr addObject:@"2017-10-15 16:30:00"];
    [arr addObject:@"2017-10-15 16:40:00"];
    [arr addObject:@"2017-11-15 07:08:00"];
    [arr addObject:@"2017-11-15 09:08:09"];
    [arr addObject:@"2017-11-15 10:00:00"];
    [arr addObject:@"2017-12-15 10:10:00"];
    [arr addObject:@"2017-12-15 12:25:05"];
    [arr addObject:@"2017-12-15 16:54:15"];
    [arr addObject:@"2017-12-15 17:00:00"];
    [arr addObject:@"2017-12-15 14:00:00"];
    [arr addObject:@"2018-01-15 06:59:00"];
    [arr addObject:@"2018-01-15 07:00:00"];
    [arr addObject:@"2018-01-15 09:00:00"];
    [arr addObject:@"2018-01-15 09:40:00"];
    [arr addObject:@"2018-01-15 10:00:00"];
    [arr addObject:@"2018-01-16 05:03:01"];
    [arr addObject:@"2018-01-16 05:04:01"];
    [arr addObject:@"2018-01-16 06:00:01"];
    [arr addObject:@"2018-01-16 09:00:01"];
    return arr;
}
-(NSMutableArray*)getListMessage : (NSInteger)topicType {
    NSMutableArray *arrTime = [self getListTimeMessage];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i = 0; i<[arrTime count]; i++)
    {
        Message*message = [[Message alloc] init];
        message.type = i % 2;
        CGSize sizeContentMessage = [MessageCollectionViewCell getSizeContentMessage:message];
        message.lbSizeContentMessage = sizeContentMessage;
        message.lbTimeMessage = arrTime[i];
        message.imgProfilePhoto = @"idol_profile";
        message.lbContentMessage = @"Lorem ipsum dolor sit er elit lamet";
        message.imgPhotoEvent = @"event_logo";
        message.lbTitleSystemMessage = @"Talk TV thông báo";
        message.lbTimeSystemMessage = @"Tháng 12 năm 2017";
        //message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing";
       //message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
        message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet,";
        message.sizeMessage = CGSizeMake(0, 0);
        [arr addObject:message];
    }
    return arr;
}

-(NSMutableArray*)getListMessageMore : (NSInteger)topicType {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arrTime = [self getListMoreTimeMessage];
    for(int i = 0; i< [arrTime count]; i++)
    {
        Message*message = [[Message alloc] init];
        message.type = i % 2;
        CGSize sizeContentMessage = [MessageCollectionViewCell getSizeContentMessage:message];
        message.lbSizeContentMessage = sizeContentMessage;
        message.lbTimeMessage = arrTime[i];
        message.imgProfilePhoto = @"idol_profile";
        message.imgPhotoEvent = @"event_logo";
        message.lbTitleSystemMessage = @"Talk TV thông báo";
        message.lbTimeSystemMessage = @"Tháng 12 năm 2017";
        //message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu j j ju ";
        message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
        message.btnLinkSystemMessage = @"https://www.google.com.vn";
        message.sizeMessage = CGSizeMake(0, 0);
        [arr addObject:message];
    }
    return arr;
}

-(Message*)receiveNewMessage {
    Message*message = [[Message alloc] init];
    message.type = 0;
    NSString *dateDisplay = [NSDate stringFormDateNow];
    message.lbTimeMessage = dateDisplay;
    message.imgProfilePhoto = @"idol_profile";
    message.lbContentMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    message.imgPhotoEvent = @"event_logo";
    message.lbTitleSystemMessage = @"Talk TV thông báo";
    message.lbTimeSystemMessage = @"Tháng 12 năm 2017";
    message.lbContentSystemMessage = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
    return message;
}

@end
