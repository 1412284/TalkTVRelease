//
//  UIViewController+KeyboardAdditions.m
//

#import "UIViewController+KeyboardAdditions.h"
#import <objc/runtime.h>


@implementation UIViewController (KeyboardAdditions)


#pragma mark - Properties

- (BOOL)isKeyboardPresented {
    return [self keyboardHeight] > 0.0;
}

- (CGFloat)keyboardHeight {
    NSNumber *keyboardHeightNumber = objc_getAssociatedObject(self, @selector(keyboardHeight));
    return keyboardHeightNumber.floatValue;
}

- (void)setKeyboardHeight:(CGFloat)keyboardHeight {
    objc_setAssociatedObject(self, @selector(keyboardHeight), @(keyboardHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Notifications

- (void)startObservingKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHideNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)stopObservingKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - KAKeyboardAdditions

- (void)keyboardWillShowOrHideWithHeight:(CGFloat)height
                          animationDuration:(NSTimeInterval)animationDuration
                             animationCurve:(UIViewAnimationCurve)animationCurve {
    // override me if needed
}

- (void)keyboardShowOrHideAnimationWithHeight:(CGFloat)height
                               animationDuration:(NSTimeInterval)animationDuration
                                  animationCurve:(UIViewAnimationCurve)animationCurve {
    // override me if needed
}

- (void)keyboardShowOrHideAnimationDidFinishedWithHeight:(CGFloat)height {
    // override me if needed
}


#pragma mark - Private

- (void)keyboardWillShowOrHideNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    // When keyboard is hiding, the height value from UIKeyboardFrameEndUserInfoKey sometimes is incorrect
    // Sets it manually to 0
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    BOOL isShowNotification = [notification.name isEqualToString:UIKeyboardWillShowNotification];
    CGFloat keyboardHeight = isShowNotification ? CGRectGetHeight(keyboardFrame) : 0.0;
    
    [self setKeyboardHeight:keyboardHeight];
    
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self keyboardWillShowOrHideWithHeight:keyboardHeight
                            animationDuration:animationDuration
                               animationCurve:animationCurve];
    
    [UIView beginAnimations:@"UIViewController+KeyboardAdditions-Animation" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(keyboardAnimationDidStop:finished:context:)];
    
    [self keyboardShowOrHideAnimationWithHeight:keyboardHeight
                                 animationDuration:animationDuration
                                    animationCurve:animationCurve];
    
    [UIView commitAnimations];
}

- (void)keyboardAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    CGFloat keyboardHeight = [self keyboardHeight];
    [self keyboardShowOrHideAnimationDidFinishedWithHeight:keyboardHeight];
}

@end

