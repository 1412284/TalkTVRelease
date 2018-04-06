//
//  USListTopicFullViewController.m
//  USMessage
//
//  Created by Hoang Thuan on 11/22/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "USListTopicFullViewController.h"
#import "USMessageFullViewController.h"

#define LIMIT_SCROLL_LOAD_MORE -65
#define  buleBackgroundColor [[UIColor alloc] initWithRed:19/255.0  green:185/255.0 blue:255/255.0 alpha:1]

@interface USListTopicFullViewController ()

@end

@implementation USListTopicFullViewController

- (instancetype)init {
    if(self = [super initWithNibName:@"USBaseListTopicViewController" bundle:nil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerView.backgroundColor = buleBackgroundColor;
    //self.lbTitle.text = @"Fullview List Topic";
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Topic*topic = [self.arrListTopic objectAtIndex:indexPath.row];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
       USMessageFullViewController*messageView = [[USMessageFullViewController alloc] init];
        messageView.typeTopic = topic.type;
        messageView.title = @"TALK";
        messageView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:messageView animated:NO completion:nil];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y < LIMIT_SCROLL_LOAD_MORE && ![self.refreshControl isRefreshing]) {
//        [self.refreshControl beginRefreshing];
//        [self.tbListTopic reloadData];
//        [self.refreshControl endRefreshing];
//    }
//}

@end
