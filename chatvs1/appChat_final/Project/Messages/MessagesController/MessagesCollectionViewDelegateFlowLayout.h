//
//  MessagesCollectionViewDelegateFlowLayout.h
//  Project
//
//  Created by CPU11197-local on 11/10/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#ifndef MessagesCollectionViewDelegateFlowLayout_h
#define MessagesCollectionViewDelegateFlowLayout_h


#endif /* MessagesCollectionViewDelegateFlowLayout_h */
#import <UIKit/UIKit.h>

@class OutgoingCollectionViewCell;
@class IncomingCollectionViewCell;
@class EventCollectionViewCell;
@class EventNoImagesCollectionViewCell;

@protocol MessagesCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView heightCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)collectionView:(UICollectionView *)collectionView heightBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)collectionView:(UICollectionView *)collectionView heightCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;
@end
