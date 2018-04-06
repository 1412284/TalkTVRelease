//
//  USMessageFullViewController.m
//  USMessage
//
//  Created by Hoang Thuan on 11/23/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "USMessageFullViewController.h"

#define LIMIT_SCROLL_LOAD_MORE -65
#define  buleBackgroundColor [[UIColor alloc] initWithRed:19/255.0  green:185/255.0 blue:255/255.0 alpha:1]
@interface USMessageFullViewController ()

@end

@implementation USMessageFullViewController

- (instancetype)init {
    if(self = [super initWithNibName:@"USBaseMessageViewController" bundle:nil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView.backgroundColor = buleBackgroundColor;
    self.lbTitle.text = self.title;
    self.cvStatusBar.backgroundColor  =  buleBackgroundColor;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardSize = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (CGRectIsNull(keyboardSize)) {
        return;
    }
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         //code with animation
                         self.bottomConstraint.constant = keyboardSize.size.height;
                         [self.view layoutIfNeeded];
                         
                     } completion:^(BOOL finished) {
                         //code for completion
                      [self.cvListMessage reloadData];
                      [self scrollToBottomAnimated:YES];
                         
                     }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.0f];
    self.bottomConstraint.constant = 0.0f;
    [UIView commitAnimations];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < LIMIT_SCROLL_LOAD_MORE && ![self.refreshControl isRefreshing]) {
        [self.refreshControl beginRefreshing];
        NSMutableArray*moreMessage = [[DataCenter shareDataCenter] getListMessageMore:self.typeTopic];
        NSInteger countMoreMessage = moreMessage.count;
        if(moreMessage.count > 0) {
            [moreMessage addObjectsFromArray:self.arrListMessage];
            Message *mes = self.arrListMessage[0];
            mes.sizeMessage = CGSizeMake(0,0);
            self.arrListMessage[0] = mes;
            self.arrListMessage = moreMessage;
            [self.cvListMessage reloadData];
            [self scrollToIndexPath:[NSIndexPath indexPathForItem:countMoreMessage - 1 inSection:0] animated:NO];
            [self.refreshControl endRefreshing];
        }else{
            [self.refreshControl endRefreshing];
        }
    }
    
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        self.btnNewMessageNotification.hidden = YES;
    }
}

- (IBAction)backAction:(id)sender {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
