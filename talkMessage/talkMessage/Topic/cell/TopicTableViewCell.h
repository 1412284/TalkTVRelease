//
//  TopicTableViewCell.h
//  USMessage
//
//  Created by Hoang Thuan on 12/4/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface TopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewNewMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTimer;
@end
NS_ASSUME_NONNULL_END
