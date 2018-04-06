//
//  Detail_topic1ViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "ContentViewController.h"
#import "EventCollectionViewCell.h"
#import "EventNoImagesCollectionViewCell.h"
#import "ChatFriendCollectionViewCell.h"
#import "ChatMyselfCollectionViewCell.h"
#import "Event.h"
#import "EventData.h"

@interface ContentViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *content_collectonview;

@end

@implementation ContentViewController
NSString *mess1 = @"hi. Hi. M đang làm gì đó? Cuối tuần rảnh ko? :)  ";
NSString *mess2 = @"hi. ";

- (void)viewDidLoad {
          [super viewDidLoad];
          //if(numberOfStacks == 1){
                    UIImage* images = [UIImage imageNamed:@"icon_Back20.png"];
          self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:images style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
           self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
          
          // Do any additional setup after loading the view from its nib.
          [self.content_collectonview registerNib: [UINib nibWithNibName:@"EventCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"EventCollectionViewCell"];
          [self.content_collectonview registerNib: [UINib nibWithNibName:@"EventNoImagesCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"EventNoImagesCollectionViewCell"];
          [self.content_collectonview registerNib: [UINib nibWithNibName:@"ChatFriendCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"ChatFriendCollectionViewCell"];
          [self.content_collectonview registerNib: [UINib nibWithNibName:@"ChatMyselfCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"ChatMyselfCollectionViewCell"];
          
}

- (void)didReceiveMemoryWarning {
          [super didReceiveMemoryWarning];
          // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
          return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
          return [self.dataEvent count] + 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
          if( indexPath.row < [self.dataEvent count])
          {
          Event *event = self.dataEvent[indexPath.row];
          if (event.type == 1)
          {
                    EventCollectionViewCell *cell = (EventCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
                     [cell bindData:event];
                    return cell;
          }
          else if (event.type == 0){
                    
                    EventNoImagesCollectionViewCell *cell = (EventNoImagesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventNoImagesCollectionViewCell" forIndexPath:indexPath];
                     [cell bindData:event];
                    return cell;
                    
          }
          }
          if (indexPath.row == 2 || indexPath.row == 5)
          {
                    ChatMyselfCollectionViewCell *cell= (ChatMyselfCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ChatMyselfCollectionViewCell" forIndexPath:indexPath];
                    //cell.backgroundColor=[UIColor grayColor];
                    cell.imageview.layer.backgroundColor=[[UIColor clearColor] CGColor];
                    cell.view.layer.cornerRadius = 10;
                    cell.imageview.layer.cornerRadius= 21;
                    cell.imageview.layer.borderWidth= 1.0;
                    cell.imageview.layer.masksToBounds = YES;
                    cell.imageview.layer.borderColor=[[UIColor clearColor] CGColor];
                    cell.content_label.text = mess1;
                    return cell;
                    
          }
          
          ChatFriendCollectionViewCell *cell= (ChatFriendCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ChatFriendCollectionViewCell" forIndexPath:indexPath];
          //cell.backgroundColor=[UIColor grayColor];
          cell.imageview.layer.backgroundColor=[[UIColor clearColor] CGColor];
          cell.imageview.layer.cornerRadius= 21;
          cell.imageview.layer.borderWidth= 1.0;
          cell.imageview.layer.masksToBounds = YES;
          cell.imageview.layer.borderColor=[[UIColor clearColor] CGColor];
          cell.content_label.text = mess2;
          cell.view.layer.cornerRadius = 10;
          return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
          if( indexPath.row < [self.dataEvent count])
          {
                    Event *event = self.dataEvent[indexPath.row];
          if (event.type == 1)
          {
                    CGRect rect = [event.subTitle boundingRectWithSize:CGSizeMake(_content_collectonview.frame.size.width - 25, _content_collectonview.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}context:nil];
                    CGFloat height = 370 + rect.size.height;;
                    NSLog(@" heightcontent = %f", rect.size.height);
                    return CGSizeMake(_content_collectonview.frame.size.width,height);
                    
          }
          else if (event.type == 0){
                    CGRect rect = [event.subTitle boundingRectWithSize:CGSizeMake(_content_collectonview.frame.size.width - 25, _content_collectonview.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}context:nil];
                  
                    CGFloat height =  156 + rect.size.height;
                                        
                    NSLog(@"heigth = %f", rect.size.height);
                    return CGSizeMake(_content_collectonview.frame.size.width,height);
          }
          }
                    if (indexPath.row == 2 || indexPath.row == 5)
          {
                    CGRect r = [mess1 boundingRectWithSize:CGSizeMake(_content_collectonview.frame.size.width - 152,_content_collectonview.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}context:nil];
                    if (r.size.height < 25)
                    {
                      return CGSizeMake(_content_collectonview.frame.size.width,80);
                    }
                    CGFloat height = 60 + r.size.height;
                    NSLog(@"-------width  = %f", r.size.width);
                    return CGSizeMake(_content_collectonview.frame.size.width,height);
                    
          }
          CGRect r = [mess2 boundingRectWithSize:CGSizeMake(_content_collectonview.frame.size.width - 152,_content_collectonview.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}context:nil];
          if (r.size.height < 25)
          {
                    return CGSizeMake(_content_collectonview.frame.size.width,80);
          }
          CGFloat height = 60 + r.size.height;
          NSLog(@"heigth = %f", r.size.height);
          return CGSizeMake(_content_collectonview.frame.size.width, height);
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)goBack:(id)sender
{
          NSInteger numberOfStacks = self.navigationController.viewControllers.count;
          if(numberOfStacks > 1){
                    [self.navigationController popViewControllerAnimated:YES];
          }
          else{
                    [self dismissViewControllerAnimated:YES completion:nil];
          }
          //[self dismissViewControllerAnimated:YES completion:nil];
          
};


@end
