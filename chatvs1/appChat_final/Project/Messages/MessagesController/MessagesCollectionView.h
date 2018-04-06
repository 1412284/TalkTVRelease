//
//  MessagesCollectionView.h
//  Project
//
//  Created by CPU11197-local on 11/10/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesCollectionViewDataSource.h"
#import "MessagesCollectionViewDelegateFlowLayout.h"

@interface MessagesCollectionView : UICollectionView
@property (weak, nonatomic, nullable) id<MessagesCollectionViewDataSource> dataSource;
@property (weak, nonatomic, nullable) id<MessagesCollectionViewDelegateFlowLayout> delegate;
@end
