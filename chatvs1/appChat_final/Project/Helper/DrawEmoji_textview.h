//
//  DrawEmoji_textview.h
//  Project
//
//  Created by liem on 11/30/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmojiTextAttachment.h"
#import "RegexStr.h"
@interface DrawEmoji_textview : NSObject
+(void)insertEmojiForTextView:(UITextView*)textView emojiTag:(NSString*)value imageName:(NSString*)key;
+(NSMutableAttributedString*) AttributedStringFormString:(NSString*)contentText DicEmoji:(NSDictionary*)DicEmoji;
+(void) insertContentTextTo:(UITextView*)textView formAttributedString:(NSMutableAttributedString*)arr;
+(void)resetTextStyle:(UITextView*)textView;
@end
