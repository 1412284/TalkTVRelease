//
//  ViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "ViewController.h"
#import "ListTopicViewController.h"
#import "LiveStreamViewController.h"

#define blueColor  [[UIColor alloc] initWithRed:36/255.0  green:171/255.0 blue:226/255.0 alpha:1]
//#import "TopicData.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str = @"Hi Hello[/g000] How Are You ?";
    NSArray * arr = [str componentsSeparatedByString:@" "];
    NSLog(@"Array values are : %@",arr);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoListTopic_button:(id)sender {
    
    NSLog(@"ok ");
    [GlobalData sharedGlobalData].message = @"Nomal";
    ListTopicViewController *lt = [[ListTopicViewController alloc] initWithNibName:@"ListTopicViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lt];
    lt.title = @"List topic";
    navi.navigationBar.barTintColor = blueColor;
    [self presentViewController:navi animated:YES completion:nil];    
}
- (IBAction)gotoLivestream_button:(id)sender {
    NSLog(@"ok ");
    LiveStreamViewController *ls= [[LiveStreamViewController alloc]initWithNibName:@"LiveStreamViewController" bundle:nil];
    [self presentViewController:ls animated:YES completion:nil];
    
}


@end
