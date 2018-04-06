//
//  DataCenter.h
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
@interface DataCenter : NSObject {
    
}

+(DataCenter*)shareDataCenter;
-(void)getMessage;
-(NSMutableArray*)getListTopic;
-(NSMutableArray*)getListMessage : (NSInteger)topicType;
-(NSMutableArray*)getListMessageMore : (NSInteger)topicType;
-(NSMutableArray*)getListUnfollow;
-(Message*)receiveNewMessage;
-(NSMutableArray*)getMoreListTopic;
@end
