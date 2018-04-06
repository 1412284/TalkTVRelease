//
//  Topic.h
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
@property (strong, nonatomic) NSString *topicID;
@property NSInteger type;
@property (strong, nonatomic) NSString  *avatar;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *subTitle;
@property (strong, nonatomic) NSString  *time;
@property (nonatomic) bool newMesage;
@property (nonatomic) bool unfollow;
@end
