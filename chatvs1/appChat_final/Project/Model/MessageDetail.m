//
//  Event.m
//  Project
//
//  Created by CPU11197-local on 10/20/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "MessageDetail.h"

@implementation MessageDetail
//@synthesize time;
-(void)setTimeMesages:(NSString *)time{
    _timeMesages = time;
}
+(NSString*) createMessagesID:(NSDate*)Date senderID:(NSString*)senderId{
    NSTimeInterval interval = [Date timeIntervalSince1970];
    NSString *messagesID = [NSString stringWithFormat:@"%08x", (int)interval];
    NSLog(@"hexInterval %@", messagesID);
    messagesID = [messagesID stringByAppendingString:senderId];
    return messagesID;
}
+(MessageDetail*) init:(NSString*)messagesID topicID:(NSString*)topicID type:(NSInteger)type senderID:(NSString*)senderID  toSenderID:(NSString*)toSenderID nameSenderID:(NSString*)nameSenderID avatarURLSenderID:(NSString*)avatarURLSenderID action:(NSString*)action timeMessages:(NSString*)timeMessages title:(NSString*)title  stateSeen:(NSInteger)stateSeen contentMessages:(NSString*)contentMessages {
    MessageDetail *new = [[MessageDetail alloc] init];
    new.messagesID = messagesID;
    new.topicID = topicID;
    new.type = type;
    new.senderID = senderID;
    new.toSenderID = toSenderID;
    new.nameSenderID = nameSenderID;
    new.avatarURLSenderID = avatarURLSenderID;
    new.acttion = action;
    new.timeMesages = timeMessages;
    new.title = title;
    new.stateSeen = stateSeen;
    new.text = contentMessages;
    return new;
}
@end
