//
//  DrawEmoji_textview.m
//  Project
//
//  Created by liem on 11/30/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "DrawEmoji_textview.h"

@implementation DrawEmoji_textview
+(void)insertEmojiForTextView:(UITextView*)textView emojiTag:(NSString*)value imageName:(NSString*)key{
    //Create emoji attachment
    EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
    
    //Set tag and image
    emojiTextAttachment.emojiTag = value;
    emojiTextAttachment.image = [UIImage imageNamed:key];
    
    //Set emoji size
    emojiTextAttachment.emojiSize = CGSizeMake(21.0f,21.0f);
    
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:emojiTextAttachment];
    NSRange selectedRange = textView.selectedRange;
    if (selectedRange.length > 0) {
        [textView.textStorage deleteCharactersInRange:selectedRange];
    }
    //NSMutableAttributedString *arraystr = [[NSMutableAttributedString alloc] initWithString:@""];
    //Insert emoji image
    //[arraystr appendAttributedString:str];
    [textView.textStorage insertAttributedString:str atIndex:textView.selectedRange.location];
    
    textView.selectedRange = NSMakeRange(textView.selectedRange.location+1, 0);
    //Reset text style
    [self resetTextStyle:textView];
}
+(NSMutableAttributedString*) AttributedStringFormString:(NSString*)contentText DicEmoji:(NSDictionary*)DicEmoji {
    NSMutableArray *res;
    res = [[NSMutableArray alloc] init];
    res = [RegexStr splitCommas:contentText];
    
    //self.str = @"";
    NSLog(@"count %ld", [res count]);
    NSMutableAttributedString *arr = [[NSMutableAttributedString alloc] init];
    for (NSString *s in res) {
        NSLog(@"key = %@", s);
        NSString *key = s;
        NSString *value =  DicEmoji[key];
        NSLog(@" = value %@", value);
        if (value != nil)
        {
            //Create emoji attachment
            EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
            //Set tag and image
            emojiTextAttachment.emojiTag = s;
            emojiTextAttachment.image = [UIImage imageNamed:value];
            //Set emoji size
            emojiTextAttachment.emojiSize = CGSizeMake(18,18);
            // begin: changed by liu wei zhen: <<<
            NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:emojiTextAttachment];
            [arr appendAttributedString:str];
            // _str = [self.str stringByAppendingString:@"00"];
        } else {
            
            [arr appendAttributedString:[[NSAttributedString alloc] initWithString:s]];
            //_str = [self.str stringByAppendingString:s];
        }
        
    }
    return arr;
    
}
+(void) insertContentTextTo:(UITextView*)textView formAttributedString:(NSMutableAttributedString*)arr{
    textView.text = nil;
    [textView setFont:[UIFont systemFontOfSize:14]];
    NSRange selectedRange = textView.selectedRange;
    if (selectedRange.length > 0) {
        
        [textView.textStorage deleteCharactersInRange:selectedRange];
    }
    //Insert emoji image
    [textView.textStorage insertAttributedString:arr atIndex:textView.selectedRange.location];
    textView.selectedRange = NSMakeRange(textView.selectedRange.location+1,0);
    //Reset text style
    [DrawEmoji_textview resetTextStyle:textView];
}
+(void)resetTextStyle:(UITextView*)textView{
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, textView.textStorage.length);
    
    [textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    
    [textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:wholeRange];
}
@end
