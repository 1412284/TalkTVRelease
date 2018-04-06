//
//  USBaseMessageViewController.m
//  USMessage
//
//  Created by Hoang Thuan on 11/23/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "USBaseMessageViewController.h"
#import "MessageEventCollectionViewCell.h"
#import "MessageSystemCollectionViewCell.h"
#import "MessageCollectionViewCell.h"
#import "NSDate+NVTimeAgo.h"
@interface USBaseMessageViewController ()

@end

@implementation USBaseMessageViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    _arrListMessage = [[DataCenter shareDataCenter] getListMessage:_typeTopic];
    [_cvListMessage reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // ...
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification  object: nil];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   [self scrollToBottomAnimated:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_cvListMessage reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_cvListMessage registerNib:[UINib nibWithNibName:@"MessageEventCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MessageEventID"];
    
    [_cvListMessage registerNib:[UINib nibWithNibName:@"MessageSystemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MessageSystemID"];
    
    _refreshControl = [UIRefreshControl new];
    [_cvListMessage addSubview:_refreshControl];
    _cvListMessage.alwaysBounceVertical = YES;
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    [_cvListMessage addGestureRecognizer:tap];
    
    _tvInputMessage.delegate = self;
    
    _btnNewMessageNotification.hidden = YES;
    _btnNewMessageNotification.layer.cornerRadius = 5.0f;
    _btnNewMessageNotification.layer.masksToBounds = YES;
    
    _lbWriteMessageNotification.hidden = YES;
    _lbWriteMessageNotification.layer.cornerRadius = 5.0f;
    _lbWriteMessageNotification.layer.masksToBounds = YES;
    
    [_btnSendMessage setBackgroundImage:[UIImage imageNamed:@"sent_icon_active"] forState:UIControlStateNormal];
    [_btnSendMessage setBackgroundImage:[UIImage imageNamed:@"sent_icon_not_active"] forState:UIControlStateDisabled];
    
    //Demo Receive New Message
    
//    [NSTimer scheduledTimerWithTimeInterval: 10.0
//                                                  target: self
//                                                selector:@selector(receiveNewMessage:)
//                                                userInfo: [[DataCenter shareDataCenter] receiveNewMessage] repeats:YES];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrListMessage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCollectionViewCell*cell;
    NSString *cellIdentifier = nil;
    Message*message = [_arrListMessage objectAtIndex:indexPath.row];

    switch (message.type) {
        case TYPE_SYSTEM_MESSAGE:
            cellIdentifier = @"MessageSystemID";
            break;
        case TYPE_EVENT_MESSAGE:
            cellIdentifier = @"MessageEventID";
            break;
        default:
            cellIdentifier = @"MessageSystemID";
            break;
    }
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [self updateConstraint:cell.heightTimeMessage withConstant:[self collectionView:_cvListMessage heightTimeMessageAtIndexPath:indexPath]];
    [self updateConstraint:cell.heightContent withConstant:message.lbSizeContentMessage.height];
    [cell updateConstraints];
    [cell bindData:message];
    cell.lbLinkDetailMessage.tag = indexPath.row;
    [cell.lbLinkDetailMessage addTarget:self
                                 action:@selector(openLinkDetailMessage:)
                       forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant
{
    if (constraint.constant == constant) {
        return;
    }
    constraint.constant = constant;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    Message*message = [_arrListMessage objectAtIndex:indexPath.row];
    if(message.sizeMessage.height == 0)
    {
        CGSize sizeContentMessage = [MessageCollectionViewCell getSizeContentMessage:message];
        CGFloat  heightTimeMessage = [self collectionView:_cvListMessage heightTimeMessageAtIndexPath:indexPath];
        message.lbSizeContentMessage = sizeContentMessage;
        if(message.type == TYPE_SYSTEM_MESSAGE)
        {
            size = CGSizeMake(ceilf(self.view.frame.size.width), ceilf(sizeContentMessage.height + heightTimeMessage + CELL_CONTENT_WITHOUT_SYSTEM_MESSAGE_HEIGHT));
        }else //message.type == TYPE_EVENT_MESSAGE
        {
            size = CGSizeMake(ceilf(self.view.frame.size.width), ceilf(sizeContentMessage.height + heightTimeMessage + CELL_CONTENT_WITHOUT_EVENT_MESSAGE_HEIGHT));
        }
        message.sizeMessage = size;
    }
    return message.sizeMessage;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView heightTimeMessageAtIndexPath:(NSIndexPath *)indexPath {
        if(indexPath.row>0)
        {
            Message *messages = self.arrListMessage[indexPath.row];
            Message *messages2 = self.arrListMessage[indexPath.row- 1];
            NSDate *date = [NSDate dateFormStringFormat:messages.lbTimeMessage];
            NSDate *date2 = [NSDate dateFormStringFormat:messages2.lbTimeMessage];
            CGFloat minuteDifference = [date timeIntervalSinceDate:date2]/60.0;
            if (minuteDifference< 60.0f){
                return 0;
            }
            else
            {
                return 21;

            }

        } else if(indexPath.row == 0){
            return 21;
        }
    return 0;
}
- (IBAction)backAction:(id)sender {
    
}

- (IBAction)sendMessageAction:(id)sender {
    Message *mes = self.arrListMessage[[self.arrListMessage count] - 1];
    mes.sizeMessage = CGSizeMake(0,0);
    self.arrListMessage[[self.arrListMessage count] - 1] = mes;
    Message*message = [[Message alloc] init];
    message.type = 2;//TYPE_SEND_MESSAGE;
    NSString *dateDisplay = [NSDate stringFormDateNow];
    message.lbTimeMessage = dateDisplay;
    message.imgProfilePhoto = @"profilePhoto";
    message.lbContentMessage = _tvInputMessage.text;
    message.sizeMessage = CGSizeMake(0, 0);
    [_arrListMessage addObject:message];
     _btnSendMessage.enabled = NO;
    UITextView *textView = self.tvInputMessage;
    textView.text = nil;
    [textView.undoManager removeAllActions];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
    [_cvListMessage.collectionViewLayout invalidateLayout];
    [_cvListMessage reloadData];
    [self scrollToBottomAnimated:YES];
}

- (IBAction)showNewMessageAction:(id)sender {
    _btnNewMessageNotification.hidden = YES;
     [self scrollToBottomAnimated:YES];
}

-(void)receiveNewMessage:(NSTimer*)theTimer
{
    Message*newMesage = (Message*)[theTimer userInfo];
    [_arrListMessage addObject:newMesage];
    [_cvListMessage reloadData];
    CGRect visibleRect = (CGRect){.origin = _cvListMessage.contentOffset, .size = _cvListMessage.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [_cvListMessage indexPathForItemAtPoint:visiblePoint];
    if(visibleIndexPath.row == _arrListMessage.count - 2 || visibleIndexPath.row == _arrListMessage.count - 3)
    {
       [self scrollToBottomAnimated:YES];
    } else {
        _btnNewMessageNotification.hidden = NO;
    }
}

-(void)closeKeyBoard {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    [_tvInputMessage resignFirstResponder];
    [UIView commitAnimations];
}

- (void)textViewDidChange:(UITextView *)textView {
    if([textView hasText])
    {
        _btnSendMessage.enabled = YES;
    }else{
        _btnSendMessage.enabled = NO;
    }
}

-(void)openLinkDetailMessage:(UIButton*)sender
{
    Message*message = [_arrListMessage objectAtIndex:sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message.btnLinkSystemMessage]];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
}

-(void)keyboardDidHide:(NSNotification *)notification {
    
}
- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self.cvListMessage numberOfSections] == 0) {
        return;
    }
    NSIndexPath *lastCellIndexPath = [NSIndexPath indexPathForItem:([self.cvListMessage numberOfItemsInSection:0] - 1) inSection:0];
    [self scrollToIndexPath:lastCellIndexPath animated:animated];
}


- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    
    if ([self.cvListMessage numberOfSections] <= indexPath.section) {
        return;
    }
    
    NSInteger numberOfItems = [self.cvListMessage numberOfItemsInSection:indexPath.section];
    if (numberOfItems == 0) {
        return;
    }
    CGFloat collectionViewContentHeight = self.cvListMessage.contentSize.height;
    CGFloat collectionViewHeight = CGRectGetHeight(self.cvListMessage.bounds);
    BOOL isContentTooSmall = (collectionViewContentHeight < collectionViewHeight);
    if (isContentTooSmall) {
        //  workaround for the first few messages not scrolling
        //  when the TableView view content size is too small, `scrollToItemAtIndexPath:` doesn't work properly
        [self.cvListMessage scrollRectToVisible:CGRectMake(0.0, collectionViewContentHeight - 1.0f, 1.0f, 1.0f)
                                          animated:animated];
        return;
    }
    NSInteger row = MAX(MIN(indexPath.row, numberOfItems - 1), 0);
    indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    //  workaround for really long messages not scrolling
    //  if last message is too long, use scroll position bottom for better appearance, else use top
     Message*message = [_arrListMessage objectAtIndex:indexPath.row];
    CGFloat cellHeight = message.sizeMessage.height;
    CGFloat maxHeightForVisibleMessage = CGRectGetHeight(self.cvListMessage.bounds)
    - self.cvListMessage.contentInset.top
    - self.cvListMessage.contentInset.bottom;
    UICollectionViewScrollPosition scrollPosition = (cellHeight > maxHeightForVisibleMessage) ? UICollectionViewScrollPositionBottom : UICollectionViewScrollPositionTop;
    [self.cvListMessage scrollToItemAtIndexPath:indexPath
                                atScrollPosition:scrollPosition
                                        animated:animated];
    
}

@end
