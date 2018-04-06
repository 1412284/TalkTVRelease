//
//  Message.h
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//
#import <Foundation/Foundation.h>
#include <CoreGraphics/CGGeometry.h>


@interface Message : NSObject
@property (strong, nonatomic) NSString *messagesID;
@property NSInteger type;

@property (strong, nonatomic) NSString *lbTimeMessage;
@property (strong, nonatomic) NSString *imgProfilePhoto;
@property (strong, nonatomic) NSString *lbContentMessage;

@property (strong, nonatomic) NSString *imgPhotoEvent;

@property (strong, nonatomic) NSString *lbTitleSystemMessage;
@property (strong, nonatomic) NSString *lbTimeSystemMessage;
@property (strong, nonatomic) NSString *lbContentSystemMessage;
@property (strong, nonatomic) NSString *btnLinkSystemMessage;
@property (nonatomic, assign) CGSize lbSizeContentMessage;
@property (nonatomic, assign) CGSize sizeMessage;
@end
