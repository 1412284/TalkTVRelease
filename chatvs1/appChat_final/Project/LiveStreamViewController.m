//
//  LiveStreamViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "LiveStreamViewController.h"
#import "MessagesViewController.h"
#import "ViewController.h"
#import "MessageDetail.h"
#import "GlobalData.h"


@interface LiveStreamViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation LiveStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)gotoMessenger_button:(id)sender {
    NSLog(@" go to messenger ");
    MessagesViewController *mss = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mss];
    navi.modalPresentationStyle = UIModalPresentationCustom;
     navi.transitioningDelegate = self;
    [GlobalData sharedGlobalData].message = @"Haft";
     mss.screenView = livestream;
    mss.toSenderID = @"78878";
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
};
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
     _halfModalPC = [[HalfModalPC alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return  self.halfModalPC;
}


@end
