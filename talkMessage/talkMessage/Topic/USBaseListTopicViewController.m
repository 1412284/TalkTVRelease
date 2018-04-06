//
//  USBaseListTopicViewController.m
//  USMessage
//
//  Created by Hoang Thuan on 11/22/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "USBaseListTopicViewController.h"
#import "TopicTableViewCell.h"
#import "NSDate+NVTimeAgo.h"

@interface USBaseListTopicViewController ()

@end

@implementation USBaseListTopicViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _arrListTopic = [[DataCenter shareDataCenter] getListTopic];
    [_tbListTopic reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tbListTopic registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TopicTableCellID"];
    _lbTitle.text = self.title;
    _tbListTopic.alwaysBounceVertical = YES;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrListTopic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopicTableCellID";
    TopicTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Topic*topic = [_arrListTopic objectAtIndex:indexPath.row];
    cell.lbContent.text = topic.subTitle;
    cell.lbTimer.text = [NSDate DatetimeFormattedAsTimeAgoTopic:topic.time];
    if(topic.newMesage == YES) {
        cell.viewNewMessage.hidden = NO;
    }else{
        cell.viewNewMessage.hidden = YES;
    }
    UIImage*imgProfile;
    cell.lbNickName.text = @"TALK";
    imgProfile = [UIImage imageNamed:@"Talk"];
    cell.imgProfilePhoto.image = imgProfile;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrListTopic removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [_tbListTopic deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath]                         withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
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
