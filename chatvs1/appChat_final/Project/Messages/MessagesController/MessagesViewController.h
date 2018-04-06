//
//  Detail_topic3ViewController.h
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesCollectionView.h"
#import "HalfModalPC.h"
#import "UIViewController+KeyboardAdditions.h"
#import "DrawEmoji_textview.h"
#import "DBTopic.h"
#import "DBMessages.h"
#import  "AppDelegate.h"
@interface MessagesViewController : UIViewController<UIActionSheetDelegate,EventListener>

@property (weak, nonatomic, nullable) IBOutlet UIView *isUnfollowBar;
@property (nonatomic) UITapGestureRecognizer * _Nullable tapRecognizer;
@property (strong, nonatomic,nullable) NSMutableArray *dataMessages;
@property (assign, nonatomic) UIEdgeInsets   additionalContentInset;
@property (strong, nonatomic,nullable) NSMutableArray *dataContentMessages;
@property (strong,nonatomic,nullable) NSString *mySenderID;
@property  NSInteger isUnFollow;
@property (strong,nonatomic,nullable) NSString *toSenderID;
@property HalfModalPC * _Nullable halfModalPC;
//@property (strong, nonatomic) NSMutableArray *dataEmoji;
@property (strong, nonatomic,nullable) NSDictionary *DataDictionary;
@property (strong, nonatomic,nullable) NSDictionary *DicEmoji;
@property (strong, nonatomic,nullable) NSArray *emojiImages;
//@property (strong, nonatomic) NSArray *dataMessages;
@property DBMessages * _Nonnull dbMessages;
@property DBTopic * _Nonnull dbtopic;
typedef enum {
    systemMessages,
    messages
}messagesType;
@property messagesType sourceview;

typedef enum {
    nomal,
    livestream
}viewType;
@property viewType screenView;
@end

