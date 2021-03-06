
#import <UIKit/UIKit.h>

@class ComposerTextView;


/**
 *  A delegate object used to notify the receiver of paste events from a `JSQMessagesComposerTextView`.
 */
@protocol ComposerTextViewPasteDelegate <NSObject>

/**
 *  Asks the delegate whether or not the `textView` should use the original implementation of `-[UITextView paste]`.
 *
 *  @discussion Use this delegate method to implement custom pasting behavior. 
 *  You should return `NO` when you want to handle pasting. 
 *  Return `YES` to defer functionality to the `textView`.
 */
- (BOOL)composerTextView:(ComposerTextView *)textView shouldPasteWithSender:(id)sender;

@end

/**
 *  An instance of `JSQMessagesComposerTextView` is a subclass of `UITextView` that is styled and used 
 *  for composing messages in a `JSQMessagesViewController`. It is a subview of a `JSQMessagesToolbarContentView`.
 */
@interface ComposerTextView : UITextView

/**
 *  The text to be displayed when the text view is empty. The default value is `nil`.
 */
@property (copy, nonatomic, nullable) NSString *placeHolder;

/**
 *  The color of the place holder text. The default value is `[UIColor lightGrayColor]`.
 */
@property (strong, nonatomic) UIColor *placeHolderTextColor;

/**
 *  The insets to be used when the placeholder is drawn. The default value is `UIEdgeInsets(5.0, 7.0, 5.0, 7.0)`.
 */
@property (assign, nonatomic) UIEdgeInsets placeHolderInsets;

/**
 *  The object that acts as the paste delegate of the text view.
 */
@property (weak, nonatomic, nullable) id<ComposerTextViewPasteDelegate>  pasteDelegate;

/**
 *  Determines whether or not the text view contains text after trimming white space 
 *  from the front and back of its string.
 *
 *  @return `YES` if the text view contains text, `NO` otherwise.
 */
- (BOOL)hasText;

@end

