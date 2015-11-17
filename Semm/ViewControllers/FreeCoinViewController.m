//
//  FreeCoinViewController.m
//  Semm
//
//  Created by 郭洪军 on 11/2/15.
//  Copyright © 2015 Adwan. All rights reserved.
//

#import "FreeCoinViewController.h"
#import "CommonDefine.h"
#import "FcCollectionCell.h"
#import "PayView.h"
#import "CommonMethods.h"

#import "DataManager.h"

@interface FreeCoinViewController ()

@end

@implementation FreeCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layout.itemSize = CGSizeMake((93.0 * SCREEN_WIDTH)/320.0f, (130.0 * SCREEN_WIDTH)/320.0f);
    
    [self.collectionView registerClass:[FcCollectionCell class] forCellWithReuseIdentifier:@"fcpic"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"fcpic";
    FcCollectionCell* cell = (FcCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
    NSString* imageToLoad = [NSString stringWithFormat:@"fc_%ld.png",(long)indexPath.row+ 1];
    cell.imgView.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell* cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blackColor];
    
    NSURL * myURL_APP_A = [NSURL URLWithString:URL_STRING_TWO];
    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        [[UIApplication sharedApplication] openURL:myURL_APP_A];
    }
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buyMemberAction:(id)sender {
    
//    [[DataManager sharedManager] setFirstIdx:2];
//    [[DataManager sharedManager] setSecondIdx:0];
//    
//    NSString* key = [NSString stringWithFormat:@"a%dandb%d",1,0];
    
    NSString* key = @"isBought";
    
    int success = [[[NSUserDefaults standardUserDefaults]valueForKey:key] intValue];
    
    if (1 == success) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"http://115.231.181.68/D197985770E67405D6F5B3B66AA2D6DCAEFAB8E7.mp4"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
    }else
    {
        PayView* view = [[PayView alloc]initWithFrame:CGRectMake(100, 100, 100, 200)];
        [view setFrame:CGRectMake(0, 0, 300*SCREEN_WIDTH/320.0f, 420*SCREEN_WIDTH/320.0f)];
        [view setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2) ];
        
        [CommonMethods transitionWithType:kCATransitionFade WithSubtype:kCATransitionFromTop ForView:self.view];
        
        [self.view addSubview:view];
    }
    
}




@end
