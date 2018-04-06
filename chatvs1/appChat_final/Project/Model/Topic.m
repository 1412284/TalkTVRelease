//
//  Topic.m
//  Topic
//
//  Created by Do Nhat Khanh on 9/14/17.
//  Copyright © 2017 Do Nhat Khanh. All rights reserved.
//

#import "Topic.h"

@implementation Topic
+(Topic*) init:(NSString*)topicID type:(NSInteger)type senderID:(NSString*)senderID avatarURL:(NSString*)avatarURL title:(NSString*)title subtitle:(NSString*)subtitle date:(NSString*)date unfollow:(NSInteger)unfollow isSeen:(NSInteger)isSeen {
    Topic *new = [[Topic alloc] init];
    new.topicID = topicID;
    new.type = type;
    new.senderID = senderID;
    new.avatarURL = avatarURL;
    new.title = title;
    new.subTitle = subtitle;
    new.unfollow = unfollow;
    new.date = date;
    new.isSeen = isSeen;
    return new;
}
@end
