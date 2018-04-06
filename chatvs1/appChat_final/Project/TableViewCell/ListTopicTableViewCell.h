//
//  ListTopicTableViewCell.h
//  Project
//
//  Created by CPU11197-local on 11/28/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
#import "NSDate+NVTimeAgo.h"
#import "Date.h"

@interface ListTopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIImageView *avatar_imageview;
@property (weak, nonatomic) IBOutlet UIImageView *notification_imageview;
-(void) bindData:(Topic*)data;
@end
