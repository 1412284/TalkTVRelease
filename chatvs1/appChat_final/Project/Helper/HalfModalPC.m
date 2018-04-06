//
//  HalfModalPC.m
//  Topic
//
//  Created by Do Nhat Khanh on 9/13/17.
//  Copyright © 2017 Do Nhat Khanh. All rights reserved.
//

#import "HalfModalPC.h"
@interface HalfModalPC(){
    UIView *_tapView;
}
@end
@implementation HalfModalPC
- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(0, self.containerView.bounds.size.height*0.5, self.containerView.bounds.size.width, self.containerView.bounds.size.height*0.5);
}

- (void)presentationTransitionWillBegin{
    _tapView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    _tapView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dmissView)];
    [self.containerView addSubview:_tapView];
    [_tapView addGestureRecognizer:tap];
    [_tapView addSubview:self.presentedViewController.view];
}

- (void) dmissView{
  [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissalTransitionWillBegin{
    _tapView.alpha = 0;
}

@end
