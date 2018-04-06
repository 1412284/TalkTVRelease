//
//  USBaseListTopicViewController.h
//  USMessage
//
//  Created by Hoang Thuan on 11/22/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "Topic.h"

#define TYPE_TALK_TOPIC 0
NS_ASSUME_NONNULL_BEGIN
@interface USBaseListTopicViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *cvStatusBar;
@property (weak, nonatomic) IBOutlet UITableView *tbListTopic;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBackButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (strong, nonatomic) NSMutableArray*arrListTopic;
@property (strong, nonatomic) NSMutableArray*arrListUnfollow;
- (IBAction)backAction:(id)sender;
@end
NS_ASSUME_NONNULL_END
