//
//  MessagesCollectionViewCell.h
//  DemoChat
//
//  Created by CPU11197-local on 10/20/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessagesLabel.h"
#import "MessageDetail.h"
#import "NSDate+NVTimeAgo.h"
#import "Date.h"
#import "RegexStr.h"
#import "EmojiTextAttachment.h"
#import "DrawEmoji_textview.h"
@interface MessagesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic, readonly, nullable) NSDictionary *DicEmoji;
@property (strong, nonatomic) NSString * _Nullable str;
-(void) bindData:(MessageDetail*_Nullable)messages ContentTextMessages:(NSMutableAttributedString*)ContentText;
-(void)bindConstantWithtWidth_MAX_textView:(CGFloat)width_MAX_textView heightCellTop:(CGFloat)heightCellTop heightBubbleTop:(CGFloat)heightBubbleTop heightCellBottom:(CGFloat)heightCellBottom;
/**
 *  Returns the label that is pinned to the top of the cell.
 *  This label is most commonly used to display message timestamps.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesLabel *cellTopLabel;

/**
 *  Returns the label that is pinned just above the messageBubbleImageView, and below the cellTopLabel.
 *  This label is most commonly used to display the message sender.
 */
@property (weak, nonatomic, readonly, nullable) UILabel *messageBubbleTopLabel;

/**
 *  Returns the label that is pinned to the bottom of the cell.
 *  This label is most commonly used to display message delivery status.
 */
@property (weak, nonatomic, readonly, nullable) UILabel *cellBottomLabel;

/**
 *  Returns the text view of the cell. This text view contains the message body text.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly, nullable) UITextView *textView;

/**
 *  Returns the message bubble container view of the cell. This view is the superview of
 *  the cell's textView and messageBubbleImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `collectionView:cellForItemAtIndexPath:`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly, nullable) UIView *messageBubbleContainerView;

/**
 *  Returns the avatar image view of the cell that is responsible for displaying avatar images.
 */
@property (weak, nonatomic, readonly, nullable) UIImageView *avatarImageView;

/**
 *  Returns the avatar container view of the cell. This view is the superview of the cell's avatarImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `collectionView:cellForItemAtIndexPath:`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly, nullable) UIView *avatarContainerView;
@property (weak, nonatomic,readonly, nullable) IBOutlet NSLayoutConstraint *heightCellTopLabel;
@property (weak, nonatomic,readonly, nullable) IBOutlet NSLayoutConstraint *heightBubbleTopLabel;
@property (weak, nonatomic,readonly, nullable) IBOutlet NSLayoutConstraint *widthBubbleContainer;
@property (weak, nonatomic,readonly, nullable) IBOutlet NSLayoutConstraint *heightBubbleContainer;
@property (weak, nonatomic,readonly, nullable) IBOutlet NSLayoutConstraint *heightCellBottomLabel;



@end
