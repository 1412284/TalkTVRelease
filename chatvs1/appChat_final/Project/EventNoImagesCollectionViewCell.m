//
//  EntertainmentNoImagesCollectionViewCell.m
//  Project
//
//  Created by CPU11197-local on 9/17/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "EventNoImagesCollectionViewCell.h"
#import "MessageDetail.h"

@implementation EventNoImagesCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(MessageDetail *)messages{
    self.view.layer.borderWidth = 2;
    self.view.layer.borderColor=[[UIColor groupTableViewBackgroundColor] CGColor];
    self.view.layer.cornerRadius = 8;
     self.dateLabel.text = [NSDate mysqlDatetimeFormattedAsTimeAgo:messages.timeMesages];
    //self.dateLabel.text = messages.timeMesages;
    self.titleLabel.text = messages.title;
    self.timeLabel.text = messages.timeMesages;
    self.subTitleLabel.text = messages.text;
    //cells.backgroundColor=[UIColor yellowColor];
}
@end
