//
//  Topic.h
//  Topic
//
//  Created by Do Nhat Khanh on 9/14/17.
//  Copyright © 2017 Do Nhat Khanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
@property (strong, nonatomic) NSString *topicID;
@property NSInteger type;
@property (strong, nonatomic) NSString  *senderID;
@property (strong, nonatomic) NSString  *avatarURL;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *subTitle;
@property (strong, nonatomic) NSString  *date;
@property NSInteger unfollow;
@property NSInteger isSeen;

+(Topic*) init:(NSString*)topicID type:(NSInteger)type senderID:(NSString*)senderID avatarURL:(NSString*)avatarURL title:(NSString*)title subtitle:(NSString*)subtitle date:(NSString*)date unfollow:(NSInteger)unfollow isSeen:(NSInteger)isSeen;
@end
