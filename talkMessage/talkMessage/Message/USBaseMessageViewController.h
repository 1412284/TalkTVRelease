//
//  USBaseMessageViewController.h
//  USMessage
//
//  Created by Hoang Thuan on 11/23/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "Message.h"
#define CELL_CONTENT_WITHOUT_MESSAGE_HEIGHT 21.0f
#define CELL_CONTENT_WITHOUT_SYSTEM_MESSAGE_HEIGHT 120.0f
#define CELL_CONTENT_WITHOUT_EVENT_MESSAGE_HEIGHT 340.0f
#define TYPE_SYSTEM_MESSAGE 0
#define TYPE_EVENT_MESSAGE 1


@protocol MessageDelegate
-(void)openTopicList;
@end

@interface USBaseMessageViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate>
NS_ASSUME_NONNULL_BEGIN
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *cvStatusBar;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbWriteMessageNotification;
@property (weak, nonatomic) IBOutlet UICollectionView *cvListMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *tvInputMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnNewMessageNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnBackButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (nonatomic, assign) id  <MessageDelegate> delegate;
@property (strong, nonatomic) NSMutableArray*arrListMessage;
@property (nonatomic) NSInteger typeTopic;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
- (IBAction)backAction:(id)sender;
- (IBAction)sendMessageAction:(id)sender;
- (IBAction)showNewMessageAction:(id)sender;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
NS_ASSUME_NONNULL_END
@end
