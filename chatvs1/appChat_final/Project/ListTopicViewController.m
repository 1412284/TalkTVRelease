//
//  ListTopicViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "ListTopicViewController.h"
#import "ViewController.h"
#import "LiveStreamViewController.h"
#import "MessagesViewController.h"
#import "SystemTableViewCell.h"
#import "UnfollowTableViewCell.h"
#import "FriendTableViewCell.h"
//#import "TopicData.h"
#import "Topic.h"
#import "MessageDetail.h"
#import "GlobalData.h"
#import "DBTopic.h"
#import "DBMessages.h"

@interface ListTopicViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property  AppDelegate *appDel;
@end
@implementation ListTopicViewController
@synthesize time_update;
int unfollow = 0;
int new = 0;

//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDel.delegate = self;
//}
- (void)SentMessages:(MessageDetail*)newMessages {
    
    NSLog(@"topic ID = %@", newMessages.topicID);
    if (unfollow == 0)
    {
        _dataTopic = [DBTopic loadDataTopic:self.dbTopic];
        
        NSLog(@"loading...............");
    }
    else{
        _dataTopic = [DBTopic loadDataTopicUnfollow:self.dbTopic];
        NSLog(@"loading unfollow...............");
    }
   NSLog(@"list topic self.tableView reloadData");
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.dbTopic = [[DBTopic alloc] initWithDatabaseFilename:@"database.sqlite"];
//    Topic *new = [[Topic alloc] init];
//    new.topicID = @"788781000liem6396";
//    new.type = 2;
//    new.senderID = @"78878";
//    new.title = @"Ngoc Huyen";
//    new.subTitle = @"uk";
    //[DBTopic executeQueryInsertTopic:new dbTopic:self.dbTopic];
    //[DBTopic executeQueryUpdateTopic:new dbTopic:self.dbTopic];
    //[DBTopic executeQueryDeleteTopic:new dbTopic:self.dbTopic];
    
    UIImage* images = [UIImage imageNamed:@"icon_Back20.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:images style:UIBarButtonItemStyleDone target:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SystemTableViewCell" bundle:nil] forCellReuseIdentifier:@"SystemTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UnfollowTableViewCell" bundle:nil] forCellReuseIdentifier:@"UnfollowTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    _appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDel.delegate = self;
    if (unfollow == 0)
    {
        _dataTopic = [DBTopic loadDataTopic:self.dbTopic];
        
        NSLog(@"loading...............");
    }
    else{
        _dataTopic = [DBTopic loadDataTopicUnfollow:self.dbTopic];
            NSLog(@"loading unfollow...............");
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)startTimedTask
//{
//   time_update  = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
//}
//
//- (void)performBackgroundTask
//{
//    //[self.delegate SentMessages];
//    //NSLog(@"Hello World!");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //Do background work
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"update UI list topic");
//            //[self.delegate SentMessages];
//            //[GlobalData sharedGlobalData].message = @"1";
//            //Update UI
//            //NSLog(@"Hello World!,  %@",[GlobalData sharedGlobalData].message);
//        });
//    });
//}

- (IBAction)goBack:(id)sender{
    //[self stopTime];
    self.appDel.delegate = nil;
    NSInteger numberOfStacks = self.navigationController.viewControllers.count;
    if(numberOfStacks > 1){
        NSMutableArray* listUnfollow = [[NSMutableArray alloc] init];
        Topic *topic = [DBTopic loadDataTopicForID:self.dbTopic TopicID:@"10001000liem6396"];
        listUnfollow = [DBTopic loadDataTopicUnfollow:self.dbTopic];
        if ([listUnfollow count] != 0){
            Topic *temp = [listUnfollow objectAtIndex:0];
            NSString *str = [temp.title stringByAppendingString:@":"];
            str = [str stringByAppendingString:temp.subTitle];
            NSLog(@"list count = %ld  %@", (long)[listUnfollow count], temp.subTitle);
            topic.subTitle = str;
            topic.date = temp.date;
            [DBTopic executeQueryUpdateTopic:topic dbTopic:self.dbTopic];
        }
        else {
            [DBTopic executeQueryDeleteTopic:topic dbTopic:self.dbTopic];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        if ([[GlobalData sharedGlobalData].message isEqual: @"Haft"]){
            [GlobalData sharedGlobalData].message = @"Nomal";
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (UIViewController*) current{
    UIViewController *_current = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (_current.presentedViewController) {
        _current = _current.presentedViewController;
    }
    _current.definesPresentationContext = YES;
    return _current;
}
-(void)viewWillDisappear:(BOOL)animated {
    NSInteger numberOfStacks = self.navigationController.viewControllers.count;
    if(numberOfStacks == 1 && unfollow == 1){
        NSLog(@" back list topic ....");
        unfollow = 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return [self.dataTopic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      Topic *topic = self.dataTopic[indexPath.row];
        if (topic.type == 0 && topic.unfollow == 0)
        {
            SystemTableViewCell *cell = (SystemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SystemTableViewCell"];
            [cell bindData:topic];
            return cell;
        }
    if (topic.type == 1 && topic.unfollow == 1 && [topic.senderID  isEqual: @"1000"])
        {
            UnfollowTableViewCell *cell = (UnfollowTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UnfollowTableViewCell"];
            [cell bindData:topic];
            return cell;
        }
            FriendTableViewCell *cell = (FriendTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell"];
            [cell bindData:topic];
            return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     Topic *topic = self.dataTopic[indexPath.row];
    if (topic.type != 1 && topic.type != 0)
    {
        MessagesViewController *ms = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
        //ms.dataMessages = [MessagesData getMessagesListData];
        ms.sourceview = messages;
          ms.title = [topic title];
        if ([[GlobalData sharedGlobalData].message isEqual: @"Haft"]){
           ms.screenView = livestream;
        }
        ms.toSenderID = [topic senderID];
        [self.navigationController pushViewController:ms animated:YES];
    }
    else if (topic.type == 0)// now content
        {
            MessagesViewController *ms = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
            ms.title = [topic title];
            ms.toSenderID = [topic senderID];
            if ([[GlobalData sharedGlobalData].message isEqual: @"Haft"]){
                ms.screenView = livestream;
            }
             //[self stopTime];
            //ms.dataMessages = [MessagesData getMessagesListData];
            [self.navigationController pushViewController:ms animated:YES];

        }
    else if(topic.type == 1 && [topic.senderID  isEqual: @"1000"]) // list unfollow
        {
            ListTopicViewController *lt = [[ListTopicViewController alloc] initWithNibName:@"ListTopicViewController" bundle:nil];
             _dataTopicUnfollow = [DBTopic loadDataTopicUnfollow:self.dbTopic];
             lt.dataTopic = self.dataTopicUnfollow;
            lt.title = [topic title];
            unfollow = 1;
            [self.navigationController pushViewController:lt animated:YES];
        } else {
            MessagesViewController *ms = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
            //ms.dataMessages = [MessagesData getMessagesListData];
            ms.sourceview = messages;
            if (topic.unfollow !=0){
            ms.isUnFollow = 1;
            }
            if ([[GlobalData sharedGlobalData].message isEqual: @"Haft"]){
                ms.screenView = livestream;
            }
            ms.toSenderID = [topic senderID];
            ms.title = [topic title];
            
            [self.navigationController pushViewController:ms animated:YES];
        }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"delete");
        Topic *topic = self.dataTopic[indexPath.row];
        
        NSLog(@"Delete.......... %@",topic.title);
        if(topic.type == 1 && [topic.senderID  isEqual: @"1000"]){
            NSLog(@"Delete nguoi la..........");
            NSMutableArray* listUnfollow = [[NSMutableArray alloc] init];
            listUnfollow = [DBTopic loadDataTopicUnfollow:self.dbTopic];
            for (Topic *temp in listUnfollow) {
                NSString *mySenderID = @"1000liem6396";
                DBMessages *dbMessages = [[DBMessages alloc] initWithDatabaseFilename:@"database.sqlite"];
                NSMutableArray* dataMessages = [DBMessages loadDataMessages:mySenderID toSenderID:temp.senderID dbMessages:dbMessages];
                NSLog(@"Count.......... %ld",[dataMessages count]);
                if([dataMessages count] >0){
                    for (int i = 0; i<[dataMessages count];i++)
                    {
                        [DBMessages executeQueryDelete:dataMessages[i] dbMessages:dbMessages];
                        NSLog(@"Count.......... %@",[dataMessages[i] text]);
                        
                    }
                }
                [DBTopic executeQueryDeleteTopic:temp dbTopic:self.dbTopic];
            }
            [DBTopic executeQueryDeleteTopic:topic dbTopic:self.dbTopic];
            
            [self.dataTopic removeObjectAtIndex:indexPath.row];
            
            
            [self.tableView reloadData];
            
        }
        else
        {
        NSString *mySenderID = @"1000liem6396";
        DBMessages *dbMessages = [[DBMessages alloc] initWithDatabaseFilename:@"database.sqlite"];
        NSMutableArray* dataMessages = [DBMessages loadDataMessages:mySenderID toSenderID:topic.senderID dbMessages:dbMessages];
        NSLog(@"Count.......... %ld",[dataMessages count]);
        if([dataMessages count] >0){
            for (int i = 0; i<[dataMessages count];i++)
            {
                [DBMessages executeQueryDelete:dataMessages[i] dbMessages:dbMessages];
                NSLog(@"Count.......... %@",[dataMessages[i] text]);
                
            }
            [DBTopic executeQueryDeleteTopic:topic dbTopic:self.dbTopic];
            
            [self.dataTopic removeObjectAtIndex:indexPath.row];
            
            
            [self.tableView reloadData];
        }
            
        }
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
