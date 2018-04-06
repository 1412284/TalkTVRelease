//
//  MessageCollectionViewCell.h
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#define FONT_SIZE 15.0f
#define CELL_CONTENT_WITHOUT_MESSAGE_WIDTH 80.0f
#define CELL_CONTENT_WITHOUT_SYSTEM_MESSAGE_WIDTH 50.0f
#define TYPE_SYSTEM_MESSAGE 0
#define TYPE_EVENT_MESSAGE 1

#define BuleColor  [[UIColor alloc] initWithRed:29/255.0  green:180/255.0 blue:250/255.0 alpha:1]

@interface MessageCollectionViewCell : UICollectionViewCell
NS_ASSUME_NONNULL_BEGIN
@property (weak, nonatomic) IBOutlet UILabel *lbTimeMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhotoEvent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleSystemMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbTimeSystemMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbContentSystemMessage;
@property (weak, nonatomic) IBOutlet UIButton *lbLinkDetailMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTimeMessage;
@property (weak, nonatomic) IBOutlet UIView *viewBackgroundContentMessage;
-(void)bindData:(Message*)message;
+(CGSize)getSizeContentMessage:(Message*)message;
NS_ASSUME_NONNULL_END
@end
