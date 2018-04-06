//
//  ListTopicTableViewCell.m
//  Project
//
//  Created by CPU11197-local on 11/28/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "ListTopicTableViewCell.h"
#define GreenColor  [[UIColor alloc] initWithRed:25/255.0  green:181/255.0 blue:254/255.0 alpha:1]
#define YellowColor [[UIColor alloc] initWithRed:255/255.0 green:207/255.0 blue:75/255.0  alpha:1]
#define AvatarColor [[UIColor alloc] initWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]
@implementation ListTopicTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.subtitle_label.alpha = 1.0f;
    self.avatar_imageview.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.notification_imageview.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.avatar_imageview.layer.cornerRadius=20;
    self.avatar_imageview.layer.borderWidth=1.0;
    self.avatar_imageview.layer.masksToBounds = YES;
    self.avatar_imageview.layer.borderColor= [[UIColor clearColor] CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}
- (void)bindData:(Topic *)data{
    switch (data.type) {
        case 0:
            self.avatar_imageview.backgroundColor = GreenColor;
            break;
            
        case 1:
            self.avatar_imageview.backgroundColor = YellowColor;
            break;
            
        default:
            self.avatar_imageview.backgroundColor = AvatarColor;
            //self.avatar_imageview.image = [UIImage imageNamed:@"defaultAvatar"];
            break;
    }
    self.title.text = data.title;
    self.time_label.text = [NSDate mysqlDatetimeFormattedAsTimeAgo:data.date];
    self.subtitle_label.text = data.subTitle;
    if(data.isSeen == 0){
        self.notification_imageview.hidden = NO;
        self.subtitle_label.font = [UIFont boldSystemFontOfSize:14];
        self.subtitle_label.textColor = [UIColor blackColor];
    } else{
        self.notification_imageview.hidden = YES;
        self.subtitle_label.font = [UIFont systemFontOfSize:14];
        self.subtitle_label.textColor = [UIColor lightGrayColor];
        
    }
}

@end
