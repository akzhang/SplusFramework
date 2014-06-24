//
//  PayHome.m
//  SplusFramework
//
//  Created by akzhang on 14-6-24.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "PayHome.h"

@interface PayHome ()

@end

@implementation PayHome

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
    
    //初始化
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.splusPayWayCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavHeight, kDeviceWidth, kDeviceHeight-kNavHeight*2-kTabBarHeight-20) collectionViewLayout:flowLayout];
    //注册
    [self.splusPayWayCollection registerClass:[CollectionPayCell class] forCellWithReuseIdentifier:@"cell"];
    //设置代理
    self.splusPayWayCollection.delegate = self;
    self.splusPayWayCollection.dataSource = self;
    [self.view addSubview:self.splusPayWayCollection];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fakeColors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.fakeColors[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MJTestViewController *test = [[MJTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
