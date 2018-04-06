//
//  Topic.h
//  Topic
//
//  Created by Do Nhat Khanh on 9/14/17.
//  Copyright © 2017 Do Nhat Khanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
@property NSInteger uin;
@property (strong, nonatomic) NSString  *avatarURL;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *subTitle;
@property (strong, nonatomic) NSArray   *child;
@end
