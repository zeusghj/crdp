//
//  FreeCoinViewController.h
//  Semm
//
//  Created by 郭洪军 on 11/2/15.
//  Copyright © 2015 Adwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeCoinViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;


- (IBAction)buyMemberAction:(id)sender;



@end
