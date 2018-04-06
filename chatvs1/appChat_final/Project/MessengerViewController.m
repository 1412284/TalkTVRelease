//
//  MessengerViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "MessengerViewController.h"
#import "ListTopicViewController.h"

@interface MessengerViewController ()

@end

@implementation MessengerViewController

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
- (IBAction)Back_button:(id)sender {
    
    NSLog(@"ok ");
    ListTopicViewController *lt = [[ListTopicViewController alloc] initWithNibName:@"ListTopicViewController" bundle:nil];
    [self presentViewController:lt animated:YES completion:nil];
    
}




@end
