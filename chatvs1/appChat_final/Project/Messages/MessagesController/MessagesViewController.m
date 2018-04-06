//
//  Detail_topic3ViewController.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "MessagesViewController.h"
#import "ListTopicViewController.h"
#import "LiveStreamViewController.h"
#import "MessagesViewController.h"
#import "EventCollectionViewCell.h"
#import "EventNoImagesCollectionViewCell.h"
#import "IncomingCollectionViewCell.h"
#import "OutgoingCollectionViewCell.h"
#import "EmojiCollectionViewCell.h"
#import "MessageDetail.h"
#import "Topic.h"
#import "Date.h"
#import "ComposerTextView.h"
#import "EmojiTextAttachment.h"
#import "NSAttributedString+EmojiExtension.h"
@interface MessagesViewController () <UIViewControllerTransitioningDelegate,MessagesCollectionViewDataSource,UICollectionViewDelegate,MessagesCollectionViewDelegateFlowLayout, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet ComposerTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet MessagesCollectionView *McollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *EmojiCollectionView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
@property (weak, nonatomic) IBOutlet UIView *emojiView;
@property (weak, nonatomic) IBOutlet UIButton *emojiButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topUnfollowBar;
@property UIActivityIndicatorView *spinner;
@property  AppDelegate *appDel;
@end
@implementation MessagesViewController
int stateSend = 0;
CGFloat keyboardHeight  = 216;
CGFloat frameHeight;
NSIndexPath *lastLongPressedIndexPath;
#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MessagesViewController class])
                          bundle:[NSBundle bundleForClass:[MessagesViewController class]]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([MessagesViewController class])
                                          bundle:[NSBundle bundleForClass:[MessagesViewController class]]];
}

+ (void)initialize {
    [super initialize];
}
- (void)dealloc
{
    _McollectionView.dataSource = nil;
    _McollectionView.delegate = nil;
    _EmojiCollectionView.dataSource = nil;
    _EmojiCollectionView.delegate = nil;
    _dataMessages = nil;
    _textView.delegate = nil;
}

#pragma mark - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self class] nib] instantiateWithOwner:self options:nil];
    [self configureDatabase];
    [self configureButtonGoBack];
    [self configuretapRecognizer];
    [self configureTextView];
    [self configureCollectionView];
    [self registerNibCollectionViewCell];
    _additionalContentInset = UIEdgeInsetsZero;
    [self updateCollectionViewInsets];
    //Set up our gesture recognizer
    [self configureLongPressGestureRecognizer];
    [self configuretapRecognizer];
    [self configureEmojiButton];
    self.transitioningDelegate = self;
    self.bottom.constant = 0.0f;
    _spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = CGPointMake(self.McollectionView.frame.size.width/2, self.McollectionView.frame.size.height/2);
    _spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDel.delegate = self;
    [self startObservingKeyboardNotifications];
//    dispatch_queue_t serialQueue = dispatch_queue_create("liem6396",DISPATCH_QUEUE_SERIAL);
//    dispatch_async(serialQueue, ^{
//        [self configureDatabase];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.McollectionView reloadData];
//            [self scrollToBottomCollectionView:NO];
//            [self.spinner stopAnimating];
//        });
//    });
    
//    if (self.McollectionView.contentSize.height > self.McollectionView.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, self.McollectionView.contentSize.height - self.McollectionView.frame.size.height);
//        [self.McollectionView setContentOffset:offset animated:NO];
//    }
    [self.spinner stopAnimating];
    [self.McollectionView reloadData];
    [self scrollToBottomCollectionView:NO];
    if(self.screenView == livestream){
        self.topUnfollowBar.constant = 44.0f;
    } else{
        self.topUnfollowBar.constant = 64.0f;
    }
    if(self.isUnFollow == 1){
        self.isUnfollowBar.hidden = NO;
        
    }
    frameHeight = [self current].view.frame.size.height;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // unregister from keyboard notifications
    [self stopObservingKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureButtonGoBack{
    UIImage* images = [UIImage imageNamed:@"icon_Back20.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:images style:UIBarButtonItemStyleDone target:self action:@selector(goBackButton:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
}
-(void) configuretapRecognizer{
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCollectionView:)];
    self.tapRecognizer.cancelsTouchesInView = NO;
    self.tapRecognizer.numberOfTapsRequired = 1;
    [self.McollectionView addGestureRecognizer:self.tapRecognizer];
}
-(void) configureDatabase{
    _mySenderID = @"1000liem6396";
    _DataDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataEmoji" ofType:@"plist"]];
    _DicEmoji = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmojiList" ofType:@"plist"]];
    _emojiImages = @[@"smiley_0.png",@"smiley_1.png",@"smiley_2.png",@"smiley_3.png",@"smiley_4.png",@"smiley_5.png",
                     @"smiley_6.png",@"smiley_7.png",@"smiley_8.png",@"smiley_9.png",@"smiley_10.png",@"smiley_11.png",
                     @"smiley_12.png",@"smiley_13.png",@"smiley_14.png",@"smiley_15.png",@"smiley_16.png",@"smiley_17.png"];
    NSLog(@"jhgsha.  %ld", [self.DataDictionary count]);
    NSLog(@"jhgsha.  %@",self.DataDictionary);
    NSString *value = self.DataDictionary[_emojiImages[0]];
    NSLog(@"value jhgsha. %@",value);
    _dbtopic = [[DBTopic alloc] initWithDatabaseFilename:@"database.sqlite"];
    _dbMessages = [[DBMessages alloc] initWithDatabaseFilename:@"database.sqlite"];
    NSString *topicID = [self.toSenderID stringByAppendingString:self.mySenderID];
    Topic *topic = [DBTopic loadDataTopicForID:self.dbtopic TopicID:topicID];
    if(topic.topicID == nil){
        self.isUnFollow = 1;
        self.title = @"Idol";
    }
    else{
    self.isUnFollow = topic.unfollow;
    self.title = topic.title;
    }
    _dataMessages = [DBMessages loadDataMessages:self.mySenderID toSenderID:self.toSenderID dbMessages:self.dbMessages];
    _dataContentMessages = [[NSMutableArray  alloc] init];
    for(int i = 0; i<[_dataMessages count]; i++){
        MessageDetail *mss = _dataMessages[i];
        NSLog(@". . .ok mss.stateSeen %@  %ld",mss.text , (long)mss.stateSeen);
        mss.stateSeen = 1;
        [DBMessages executeQueryUpdate:mss dbMessages:self.dbMessages];
        NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:mss.text DicEmoji:self.DicEmoji];
        [_dataContentMessages addObject:arr];
    }
    [DBTopic UpdateTopic:self.dataMessages dbMessages:self.dbMessages dbTopic:self.dbtopic senderID:self.mySenderID toSenderID:self.toSenderID];
    [DBTopic UpdateContentTopicUnfollow:self.dbtopic senderID:self.mySenderID];

//    topic.isSeen = 1;
//    [DBTopic executeQueryUpdateTopic:topic dbTopic:self.dbtopic];
//
    
        //    for (id key in self.DataDictionary )
        //    {
        //        NSString *value = [self.DataDictionary  objectForKey:key];
        //        NSLog(@"jhgsha. %@",value);
        //    }
}
-(void) configureLongPressGestureRecognizer{
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.McollectionView addGestureRecognizer:longPressGestureRecognizer];
}
-(void) configureEmojiButton{
    [self.emojiButton setSelected:NO];
    [_emojiButton setImage:[UIImage imageNamed:@"board_emoji.png"] forState:UIControlStateNormal];
    [_emojiButton setImage:[UIImage imageNamed:@"board_system.png"]  forState:UIControlStateSelected];
}

-(void) configureTextView{
    self.textView.delegate = self;
    self.textView.placeHolder = @"New messages";
}
-(void) configureCollectionView{
    self.McollectionView.dataSource = self;
    self.McollectionView.delegate = self;
    self.EmojiCollectionView.dataSource = self;
    self.EmojiCollectionView.delegate = self;
}
- (void)registerNibCollectionViewCell{
    [self.McollectionView registerNib: [UINib nibWithNibName:@"EventCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"EventCollectionViewCell"];
    [self.McollectionView registerNib: [UINib nibWithNibName:@"EventNoImagesCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"EventNoImagesCollectionViewCell"];
    [self.McollectionView registerNib: [UINib nibWithNibName:@"OutgoingCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"OutgoingCollectionViewCell"];
    [self.McollectionView registerNib: [UINib nibWithNibName:@"IncomingCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"IncomingCollectionViewCell"];
    [self.EmojiCollectionView registerNib: [UINib nibWithNibName:@"EmojiCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"EmojiCollectionViewCell"];
}



-(void)setAdditionalContentInset:(UIEdgeInsets)additionalContentInset{
    _additionalContentInset = additionalContentInset;
    [self updateCollectionViewInsets];
}

- (void)updateCollectionViewInsets
{
    const CGFloat top = self.additionalContentInset.top;
    const CGFloat bottom =  self.additionalContentInset.bottom;
    [self setCollectionViewInsetsTopValue:top bottomValue:bottom];
}

- (void)setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom
{
    UIEdgeInsets  insets;
    if(@available(iOS 11,*)) { // iOS 11 (or newer) ObjC code
        if (self.isUnFollow == 1){
            insets = UIEdgeInsetsMake(44.0f + top, 0.0f, bottom, 0.0f);
        }else {
            insets = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
        }
    } else { // iOS 10 or older code
        if (self.isUnFollow == 1){
             insets = UIEdgeInsetsMake(104.0f + top, 0.0f, bottom, 0.0f);
        }else {
             insets = UIEdgeInsetsMake(64.0f + top, 0.0f, bottom, 0.0f);
        }
    }
    self.McollectionView.contentInset = insets;
    self.McollectionView.scrollIndicatorInsets = insets;
}
#pragma mark - keyboard methods
- (void)keyboardWillShowOrHideWithHeight:(CGFloat)height
                       animationDuration:(NSTimeInterval)animationDuration
                          animationCurve:(UIViewAnimationCurve)animationCurve {
   
    NSLog(@"Will %@ with height = %f, duration = %f",
          self.isKeyboardPresented ? @"show" : @"hide",
          height,
          animationDuration);
}

- (void)keyboardShowOrHideAnimationWithHeight:(CGFloat)height
                            animationDuration:(NSTimeInterval)animationDuration
                               animationCurve:(UIViewAnimationCurve)animationCurve {
    if (self.screenView == livestream)
    {
        if(![self.emojiButton isSelected]){
            _bottom.constant = height;
        }
        
        if([self current].view.frame.size.height == frameHeight  && height!=0)
        {
            _bottom.constant = height;
            [self current].view.frame = CGRectMake(0,frameHeight*0.2,self.view.frame.size.width,frameHeight*1.8);
        }
    }
    else
    {
        if(![self.emojiButton isSelected])
        {
            _bottom.constant = height;
            
        }
    }
    [self.view layoutIfNeeded];
    
}

- (void)keyboardShowOrHideAnimationDidFinishedWithHeight:(CGFloat)height {
    [self setCollectionViewInsetsTopValue:0.0f bottomValue:0.0f];
    [self scrollToBottomCollectionView:YES];
    if(height >0)
    {
        keyboardHeight = height;
    }
    NSLog(@"Animation finished with height = %f", height);
    
}

#pragma mark - UIGestureRecognizer Methods
-(void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan) return;
    // Grab the location of the gesture and use it to locate the cell it was made on.
    CGPoint point = [recognizer locationInView:self.McollectionView];
    NSIndexPath *indexPath = [self.McollectionView indexPathForItemAtPoint:point];
    // Check to make sure the long press was performed on a cell.
    if (!indexPath)
    {
        return;
    }
    // Update our ivar for the menuAction: method
    lastLongPressedIndexPath = indexPath;
    // Grab our cell to display the menu controller from
    UICollectionViewCell *cell = [self.McollectionView cellForItemAtIndexPath:indexPath];
    
    // Create a custom menu item to hold the name of the model the cell is presenting
    UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"Copy" action:@selector(menuActionCopy:)];
    UIMenuItem *menuItemDelete = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(menuActionDelete:)];
    
    // Configure the shared menu controller and display it
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = @[menuItemCopy,menuItemDelete];
    [menuController setTargetRect:cell.bounds inView:cell];
    [menuController setMenuVisible:YES animated:NO];
}
-(void)menuActionCopy:(id)sender
{
    // Grab the last long-pressed index path, use it to find its corresponding
    // model, and copy that to the pasteboard
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"long long long long long ");
    [pasteboard setString:[self.dataMessages[lastLongPressedIndexPath.row] text]];
}
-(void)menuActionDelete:(id)sender
{
    NSLog(@"Delete");
    NSInteger index = [self.dataMessages count];
    [self.self.McollectionView performBatchUpdates:^{
        MessageDetail *messages = self.dataMessages[lastLongPressedIndexPath.row];
        [DBMessages executeQueryDelete:messages dbMessages:self.dbMessages];
            [self.dataMessages  removeObjectAtIndex:lastLongPressedIndexPath.row];
            [self.dataContentMessages  removeObjectAtIndex:lastLongPressedIndexPath.row];
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:lastLongPressedIndexPath.row inSection:0];
        [self.McollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    } completion:^(BOOL finished) {
        [self.McollectionView reloadData];
        if (lastLongPressedIndexPath.row == index - 1){
            [DBTopic UpdateTopic:self.dataMessages dbMessages:self.dbMessages dbTopic:self.dbtopic senderID:self.mySenderID toSenderID:self.toSenderID];
            [DBTopic UpdateContentTopicUnfollow:self.dbtopic senderID:self.mySenderID];
        }
    }];
}
#pragma mark - UIResponder Overridden Methods
- (BOOL)canPerformAction:(SEL)selector withSender:(id)sender
{
    // Make sure the menu controller lets the responder chain know
    // that it can handle its own custom menu action
    if (selector == @selector(menuActionCopy:) || selector == @selector(menuActionDelete:))
    {
        return YES;
    }
    return [super canPerformAction:selector withSender:sender];
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)scrollToBottomCollectionView:(BOOL)animated{
    if ([self.McollectionView numberOfSections] == 0) {
        return;
    }
    
    NSInteger items = [self.McollectionView numberOfItemsInSection:0];
    
    if (items > 0) {
        [self.McollectionView layoutIfNeeded];
        CGRect scrollRect = CGRectMake(0, self.McollectionView.contentSize.height - 1.f, 1.f, 1.f);
        [self.McollectionView scrollRectToVisible:scrollRect animated:animated];
    }
}
#pragma mark - Action did tap
- (void)didTapCollectionView:(UITapGestureRecognizer *) sender
{
    _bottom.constant = 0.0f;
    if([self.emojiButton isSelected]){
        [_emojiButton setSelected:NO];
    }
    if (self.screenView == livestream)
    {
        [self current].view.frame = CGRectMake(0,frameHeight,self.view.frame.size.width,frameHeight);
    }
    [self.textView resignFirstResponder];
    _bottom.constant = 0.0f;
    NSLog(@"tap tap tap.....");

}
#pragma mark - Action button
- (IBAction)sendMessagesButton:(id)sender{
    if ([self.textView hasText])
    {
        NSLog(@" message send.......:  %@ ", self.textView.text);
        NSDate* timeMessages = [NSDate date];
        NSString *dateDisplay = [Date stringFormDate:timeMessages];
        NSString *messagesID = [MessageDetail createMessagesID:timeMessages senderID:self.mySenderID];
        NSLog(@"time masages = %@    %@",dateDisplay, messagesID);
        NSString *contentMessages =[NSString stringWithFormat:@"%@", [_textView.textStorage getPlainString]];
        NSString *topicID = [self.mySenderID stringByAppendingString:self.toSenderID];
        MessageDetail *new = [MessageDetail init:messagesID topicID:topicID type:2 senderID:self.mySenderID toSenderID:self.toSenderID nameSenderID:self.title avatarURLSenderID:@"N/A" action:@"N/A" timeMessages:dateDisplay title:@"N/A" stateSeen:1 contentMessages:contentMessages];
        NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:contentMessages DicEmoji:self.DicEmoji];
        [_dataContentMessages addObject:arr];
        [DBMessages executeQueryInsert:new dbMessages:self.dbMessages];
        [self.dataMessages addObject:new];
        stateSend = 1;
        [self finishSendingMessageAnimated:YES];
    }    
}
- (IBAction)emojiButton:(id)sender{
    NSLog(@"emojiButton");
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [self.textView becomeFirstResponder];
    }
    else if (![sender isSelected])
    {
        [sender setSelected:YES];
        [self.textView resignFirstResponder];
        self.textView.inputView = nil;
        if (self.screenView == livestream)
        {
            if([self current].view.frame.size.height == frameHeight) {
                self.bottom.constant = keyboardHeight;
                [self current].view.frame = CGRectMake(0,frameHeight*0.2,self.view.frame.size.width,frameHeight*1.8);
            }
        }
        else
        {
            self.bottom.constant = keyboardHeight;
        }
        [self.McollectionView reloadData];
        [self setCollectionViewInsetsTopValue:0.0f bottomValue:0.0f];
        [self scrollToBottomCollectionView:YES];
        [[self current].view layoutSubviews];
    }
}

- (IBAction)isFollow_Button:(id)sender{
    self.isUnfollowBar.hidden = YES;
    NSString *str1 = [self.toSenderID stringByAppendingString:self.mySenderID];
    Topic *topic = [DBTopic loadDataTopicForID:self.dbtopic TopicID:str1];
    topic.unfollow = 0;
    topic.type = 2;
    [DBTopic executeQueryUpdateTopic:topic dbTopic:self.dbtopic];
    self.isUnFollow=0;
    [self updateCollectionViewInsets];
}
- (void)SentMessages:(MessageDetail*)newMessages {
    NSLog(@"Messages  self.McollectionView reloadData");
    NSString *topicID1 = [self.toSenderID stringByAppendingString:self.mySenderID];
    NSString *topicID2 = [self.mySenderID stringByAppendingString:self.toSenderID];
    if ([newMessages.topicID isEqualToString:topicID1] || [newMessages.topicID isEqualToString:topicID2])
        {
            NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:newMessages.text DicEmoji:self.DicEmoji];
            [_dataContentMessages addObject:arr];
            [_dataMessages addObject:newMessages];
             [self.McollectionView reloadData];
            [self setCollectionViewInsetsTopValue:0.0f bottomValue:0.0f];
            [self scrollToBottomCollectionView:YES];
            newMessages.stateSeen = 1;
            [DBMessages executeQueryUpdate:newMessages dbMessages:self.dbMessages];
        }
//    _dataMessages = [DBMessages loadDataMessages:self.mySenderID toSenderID:self.toSenderID dbMessages:self.dbMessages];
//    [self.dataMessages removeAllObjects];
//    for(int i = 0; i<[_dataMessages count]; i++){
//        MessageDetail *mss = _dataMessages[i];
//        NSLog(@". . .  %@  %ld",mss.text , (long)mss.stateSeen);
//        mss.stateSeen = 1;
//        [DBMessages executeQueryUpdate:mss dbMessages:self.dbMessages];
//        NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:mss.text DicEmoji:self.DicEmoji];
//        [_dataContentMessages addObject:arr];
//    }
}
- (IBAction)goBackButton:(id)sender{
    self.appDel.delegate = nil;
    NSInteger numberOfStacks = self.navigationController.viewControllers.count;
    if(numberOfStacks == 1){
        {
           [self dismissViewControllerAnimated:YES completion:^{
               ListTopicViewController *lt = [[ListTopicViewController alloc] initWithNibName:@"ListTopicViewController" bundle:nil];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lt];
                navi.modalPresentationStyle = UIModalPresentationCustom;
                navi.transitioningDelegate = self;
                lt.title = @"List topic";
                [[self current] presentViewController:navi animated:YES completion:nil];
            }];
        }
    }
    else{
        if(self.screenView == livestream  && self.bottom.constant!=0 ){
            _bottom.constant = 0;
            [self current].view.frame = CGRectMake(0,frameHeight,self.view.frame.size.width,frameHeight);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UICollectionView Datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     if(collectionView == self.McollectionView) {
    return [self.dataMessages count];
     }
    if(collectionView == self.EmojiCollectionView) {
        return [self.emojiImages count];
    }
    return 0;
}
-(CGRect) boundingRectWithSizeContent:(NSString*)text width:(CGFloat)width FontOfSize:(CGFloat)FontOfSize{
     CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 2000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontOfSize]}context:nil];
    return  rect;
 }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.McollectionView) {
        MessageDetail *messages = self.dataMessages[indexPath.row];
        
            if(self.sourceview == systemMessages){
                if (messages.type == 0)
                {
                    EventNoImagesCollectionViewCell *cell = (EventNoImagesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventNoImagesCollectionViewCell" forIndexPath:indexPath];
                    [cell bindData:messages];
                    return cell;
                }
                else if (messages.type == 1)
                {
                    EventCollectionViewCell *cell = (EventCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
                    [cell bindData:messages];
                    return cell;
                }
                
            }
        if (messages.type == 2)
        {
           
            OutgoingCollectionViewCell *cell = (OutgoingCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"OutgoingCollectionViewCell" forIndexPath:indexPath];
            cell.messageBubbleTopLabel.textAlignment =  NSTextAlignmentRight;
            cell.cellBottomLabel.textAlignment =  NSTextAlignmentRight;
            [cell bindData:messages ContentTextMessages:self.dataContentMessages[indexPath.row]];
            CGFloat heightCellTop = [self.McollectionView.delegate collectionView:collectionView heightCellTopLabelAtIndexPath:indexPath];
            CGFloat heightCellBottom = [self.McollectionView.delegate collectionView:collectionView heightCellBottomLabelAtIndexPath:indexPath];
            CGFloat heightBubbleTop = [self.McollectionView.delegate collectionView:collectionView  heightBubbleTopLabelAtIndexPath:indexPath];
            [cell bindConstantWithtWidth_MAX_textView:self.McollectionView.frame.size.width-94 heightCellTop:heightCellTop heightBubbleTop:heightBubbleTop heightCellBottom:heightCellBottom];
            return cell;
        }
        if (messages.type == 3) {
                
            
            IncomingCollectionViewCell *cell = (IncomingCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"IncomingCollectionViewCell" forIndexPath:indexPath];
            cell.textView.backgroundColor = [UIColor whiteColor];
            cell.textView.textColor = [UIColor blackColor];
            [cell bindData:messages ContentTextMessages:self.dataContentMessages[indexPath.row]];
            CGFloat heightCellTop = [self.McollectionView.delegate collectionView:collectionView heightCellTopLabelAtIndexPath:indexPath];
            CGFloat heightCellBottom = [self.McollectionView.delegate collectionView:collectionView heightCellBottomLabelAtIndexPath:indexPath];
            CGFloat heightBubbleTop = [self.McollectionView.delegate collectionView:collectionView  heightBubbleTopLabelAtIndexPath:indexPath];
            [cell bindConstantWithtWidth_MAX_textView:self.McollectionView.frame.size.width-94 heightCellTop:heightCellTop heightBubbleTop:heightBubbleTop heightCellBottom:heightCellBottom];
            return cell;
            }
    }
    if(collectionView == self.EmojiCollectionView) {
        EmojiCollectionViewCell *cell = (EmojiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCollectionViewCell" forIndexPath:indexPath];
        cell.imageView.backgroundColor = [UIColor clearColor];
         [cell.imageView setImage:[UIImage imageNamed:self.emojiImages[indexPath.row]]];
        return cell;
    }
    return nil;
}
#pragma mark - UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == self.McollectionView) {
        MessageDetail *messages = self.dataMessages[indexPath.row];
        if(self.sourceview == systemMessages) {
                if (messages.type == 1)
                {
                    CGRect rect = [self boundingRectWithSizeContent:messages.text width:self.McollectionView.frame.size.width - 25 FontOfSize:16.0f];
                    CGFloat height = 370 + rect.size.height;;
                    NSLog(@" heightcontent = %f", rect.size.height);
                    return CGSizeMake(self.McollectionView.frame.size.width,height);
                    
                }
                else if (messages.type == 0){
                    CGRect rect = [self boundingRectWithSizeContent:messages.text width:self.McollectionView.frame.size.width - 25 FontOfSize:16.0f];
                    CGFloat height =  156 + rect.size.height;
                    
                    NSLog(@"heigth = %f", rect.size.height);
                    return CGSizeMake(self.McollectionView.frame.size.width,height);
                }
        }
        if (messages.type == 2 || messages.type == 3)
        {
       //NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:messages.text DicEmoji:self.DicEmoji];
        CGRect textViewFrame = CGRectMake(0,0,self.McollectionView.frame.size.width-94,21);
        UITextView *contentTextView = [[UITextView alloc] initWithFrame:textViewFrame];
            [DrawEmoji_textview insertContentTextTo:contentTextView formAttributedString:self.dataContentMessages[indexPath.row]];
        CGSize sizeThatShouldFitTheContent = [contentTextView sizeThatFits:contentTextView.frame.size];
        // Do any additional setup after loading the view, typically from a nib.
              CGFloat heightCellTop = [self.McollectionView.delegate collectionView:collectionView heightCellTopLabelAtIndexPath:indexPath];
              CGFloat heightCellBottom = [self.McollectionView.delegate collectionView:collectionView heightCellBottomLabelAtIndexPath:indexPath];
                CGFloat heightBubbleTop = [self.McollectionView.delegate collectionView:collectionView  heightBubbleTopLabelAtIndexPath:indexPath];
            CGFloat height = sizeThatShouldFitTheContent.height + heightCellTop + heightCellBottom + heightBubbleTop + 4.0f;
            return CGSizeMake(self.McollectionView.frame.size.width,height);
        }
    }
    if(collectionView == self.EmojiCollectionView) {
        return CGSizeMake(self.EmojiCollectionView.frame.size.width/8,self.EmojiCollectionView.frame.size.width/8);
    }
    
    return CGSizeMake(0,0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView heightBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
     return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
   return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == self.McollectionView) {
        if(indexPath.row>0)
        {
            MessageDetail *messages = self.dataMessages[indexPath.row];
            MessageDetail *messages2 = self.dataMessages[indexPath.row- 1];
            NSDate *date = [Date dateFormString:messages.timeMesages];
            NSDate *date2 = [Date dateFormString:messages2.timeMesages];
            CGFloat minuteDifference = [date timeIntervalSinceDate:date2] /60.0;
            if (minuteDifference< 60){
                return 0;
            }
            else
            {
                return 21;
               
            }

        } else {
            return 21;
        }
    }
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    if(collectionView == self.EmojiCollectionView) {
        NSString *key = self.emojiImages[indexPath.row];
        NSString *value =  self.DataDictionary[key];
        [DrawEmoji_textview insertEmojiForTextView:self.textView emojiTag:value imageName:key];
    }
}


#pragma mark - UITexViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.textView becomeFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView{
    CGSize sizeThatShouldFitTheContent = [_textView sizeThatFits:_textView.frame.size];
    NSLog(@"..... %f", sizeThatShouldFitTheContent.height);
    [self setCollectionViewInsetsTopValue:0.0f bottomValue:0.0f];
    [self scrollToBottomCollectionView:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        
    if ([self.textView hasText])
    {
        NSLog(@" message send.......:  %@ ", self.textView.text);
        NSDate* timeMessages = [NSDate date];
        NSString *dateDisplay = [Date stringFormDate:timeMessages];
        NSString *messagesID = [MessageDetail createMessagesID:timeMessages senderID:self.toSenderID];
        NSLog(@"time masages = %@    %@",dateDisplay, messagesID);
        NSString *contentMessages =[NSString stringWithFormat:@"%@", [_textView.textStorage getPlainString]];
        NSString *topicID = [self.mySenderID stringByAppendingString:self.toSenderID];
        MessageDetail *new = [MessageDetail init:messagesID topicID:topicID type:3 senderID:self.toSenderID toSenderID:self.mySenderID nameSenderID:self.title avatarURLSenderID:@"N/A" action:@"N/A" timeMessages:dateDisplay title:@"N/A" stateSeen:0 contentMessages:contentMessages];
        NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:contentMessages DicEmoji:self.DicEmoji];
        [_dataContentMessages addObject:arr];
        [DBMessages executeQueryInsert:new dbMessages:self.dbMessages];
        [self.dataMessages addObject:new];
       
        stateSend = 1;
        [self finishSendingMessageAnimated:YES];
    }
        return  NO;
    }
    return YES;
}

- (void)finishSendingMessageAnimated:(BOOL)animated {
    UITextView *textView = self.textView;
    textView.text = nil;
    [textView.undoManager removeAllActions];    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
    [self.McollectionView reloadData];
    [self.EmojiCollectionView reloadData];
    [DBTopic UpdateTopic:self.dataMessages dbMessages:self.dbMessages dbTopic:self.dbtopic senderID:self.mySenderID toSenderID:self.toSenderID];
    [DBTopic UpdateContentTopicUnfollow:self.dbtopic senderID:self.mySenderID];
    [self setCollectionViewInsetsTopValue:0.0f bottomValue:0.0f];
    [self scrollToBottomCollectionView:YES];
}

- (UIViewController*) current{
    UIViewController *_current = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (_current.presentedViewController) {
        _current = _current.presentedViewController;
    }
    _current.definesPresentationContext = YES;
    return _current;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    _halfModalPC = [[HalfModalPC alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return  self.halfModalPC;
}

@end

