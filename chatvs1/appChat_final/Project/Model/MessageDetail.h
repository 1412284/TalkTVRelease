//
//  Event.h
//  Project
//
//  Created by CPU11197-local on 10/20/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDetail : NSObject
@property (strong, nonatomic) NSString *messagesID;
@property NSInteger type;
@property (strong, nonatomic) NSString *senderID;
@property (strong, nonatomic) NSString  *nameSenderID;
@property (strong, nonatomic) NSString  *avatarURLSenderID;
@property (strong, nonatomic) NSString *toSenderID;
@property (strong, nonatomic) NSString  *timeMesages;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *text;
@property (strong, nonatomic) NSString  *topicID;
@property (strong, nonatomic) NSString  *acttion;
@property NSInteger stateSeen;
+(NSString*) createMessagesID:(NSDate*)Date senderID:(NSString*)senderId;
+(MessageDetail*) init:(NSString*)messagesID topicID:(NSString*)topicID type:(NSInteger)type senderID:(NSString*)senderID  toSenderID:(NSString*)toSenderID nameSenderID:(NSString*)nameSenderID avatarURLSenderID:(NSString*)avatarURLSenderID action:(NSString*)action timeMessages:(NSString*)timeMessages title:(NSString*)title  stateSeen:(NSInteger)stateSeen contentMessages:(NSString*)contentMessages;
@end
