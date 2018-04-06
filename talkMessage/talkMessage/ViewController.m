//
//  ViewController.m
//  talkMessage
//
//  Created by CPU11197-local on 3/6/18.
//  Copyright © 2018 CPU11197-local. All rights reserved.
//

#import "ViewController.h"
#import "USMessageFullViewController.h"
#import "USListTopicFullViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)fullSreenAction:(id)sender {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    USListTopicFullViewController*fullView = [[USListTopicFullViewController alloc] init];
    fullView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    fullView.title = @"TALK";
    [self presentViewController:fullView animated:NO completion:nil];
    
}

- (IBAction)FullMessage:(id)sender {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    USMessageFullViewController*fullView = [[USMessageFullViewController alloc] init];
    fullView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    fullView.title = @"TALK";
    [self presentViewController:fullView animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
