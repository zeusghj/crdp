//
//  HotPlayViewController.m
//  Semm
//
//  Created by 郭洪军 on 11/2/15.
//  Copyright © 2015 Adwan. All rights reserved.
//

#import "HotPlayViewController.h"
#import "SemmCell.h"
#import "CommonDefine.h"
#import "PayView.h"
#import "CommonMethods.h"
#import "DataManager.h"

#import "MJRefresh.h"

@interface HotPlayViewController ()

/**
 *  随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray* fakeData;

@end

@implementation HotPlayViewController

/**
 *  数据的懒加载
 */

- (NSMutableArray *)fakeData
{
    if (!_fakeData) {
        self.fakeData = [NSMutableArray array];
        
        for (int i=0; i<12; i++) {
            [self.fakeData addObject:MJRandomData];
        }
    }
    
    return _fakeData;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //集成刷新控件
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    //设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRereshing];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
    
    // 马上进入刷新状态
//    [self.tableView.header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header beginRefreshing];
    });
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.fakeData insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.header endRefreshing];
        
        NSURL* oUrl = [NSURL URLWithString:URL_STRING_1];
        if (![[UIApplication sharedApplication] canOpenURL:oUrl]) {
            NSURL * myURL_APP_A = [NSURL URLWithString:URL_STRING_TWO];
            
            if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
                [[UIApplication sharedApplication] openURL:myURL_APP_A];
            }
        }
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.fakeData addObject:MJRandomData];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.footer endRefreshingWithNoMoreData];
    });
}

#pragma mark 只加载一次数据
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.fakeData addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        self.tableView.footer.hidden = YES;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SemmCell";
    
    SemmCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
//    cell.backgroundColor = [UIColor redColor];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SemmCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
    NSString* imageToLoad = [NSString stringWithFormat:@"seh_%ld.png",(long)indexPath.row];
    cell.imgView.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}


#pragma mark -- Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (140.0f * SCREEN_WIDTH) / 320.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹出支付页面
//    [[DataManager sharedManager] setFirstIdx:1];
//    [[DataManager sharedManager] setSecondIdx:(int)indexPath.row];
//    
//    NSString* key = [NSString stringWithFormat:@"a%dandb%d",1,(int)indexPath.row];
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
        
        [self.view.window addSubview:view];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
