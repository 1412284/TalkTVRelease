//
//  Content1CollectionViewCell.h
//  Project
//
//  Created by CPU11197-local on 9/14/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetail.h"
#import "NSDate+NVTimeAgo.h"
#import "Date.h"
@interface EventCollectionViewCell: UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarURLImageViews;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *view;
-(void) bindData:(MessageDetail*)messages;
@end
