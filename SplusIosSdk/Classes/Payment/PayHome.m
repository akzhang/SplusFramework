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
    
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _imageNameArray = [NSArray arrayWithObjects:@"splus_alipay_app", @"splus_alipay_web", @"splus_post", @"splus_credit", @"splus_mobile", @"splus_unicom", @"splus_shengda", @"splus_human",nil];
    
    _imageNameArrayCh = [NSArray arrayWithObjects:@"splus_alipay_app_choose", @"splus_alipay_web_choose", @"splus_credit_choose", @"splus_credit_choose", @"splus_mobile_choose", @"splus_unicom_choose", @"splus_shengda_choose", @"splus_human_choose",nil];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _splusPayText.text = @"充值中心";
    _splusPayText.font = [UIFont systemFontOfSize:20.0];
    _splusPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    
    _splusWelText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 80, 60, 80, 50)];
    _splusWelText.text = @"欢迎您, ";
    _splusWelText.font = [UIFont systemFontOfSize:18.0];
    _splusWelText.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_splusWelText];
    
    _splusUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 60, 80, 50)];
    _splusUserName.text = @"斗破苍穹";
    _splusUserName.font = [UIFont systemFontOfSize:18.0];
    _splusUserName.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusUserName];
    
    _splusChooseWay = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 100, 200, 50)];
    _splusChooseWay.text = @"请点击适合您的充值方式";
    _splusChooseWay.font = [UIFont systemFontOfSize:18.0];
    _splusChooseWay.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_splusChooseWay];
    
    PSUICollectionViewFlowLayout *layout = [[PSUICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;

    if (_orientation != UIDeviceOrientationPortrait) {
        _splusPayWayCollection = [[PSUICollectionView alloc] initWithFrame:CGRectMake(40, 150, SCREENWIDTH - 80, SCREENHEIGHT - 150) collectionViewLayout:layout];
    }else
    {
        _splusPayWayCollection = [[PSUICollectionView alloc] initWithFrame:CGRectMake(10, 150, SCREENWIDTH - 20, SCREENHEIGHT - 170) collectionViewLayout:layout];
    }
    _splusPayWayCollection.delegate = self;
    _splusPayWayCollection.dataSource = self;
    [_splusPayWayCollection reloadData];
    _splusPayWayCollection.backgroundColor = [UIColor whiteColor];
    [_splusPayWayCollection registerClass:[CollectionPayCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_splusPayWayCollection];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//back
-(void)yyPayBackClick
{
    [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    NSLog(@"hello, world");
}

#pragma mark -
#pragma mark Collection View Data Source

- (NSString *)formatIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionPayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //图片名称
    NSString *imageToLoad = [_imageNameArray objectAtIndex:indexPath.row];
    //加载图片
    [cell.cellButton setImage:[GetImage imagesNamedFromCustomBundle:imageToLoad] forState:UIControlStateNormal];
//    cell.cellButton.image = [GetImage imagesNamedFromCustomBundle:imageToLoad];

    //设置背景色
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(96, 75); ;
}

- (NSInteger)collectionView:(PSUICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 8;
}

//UICollectionView被选中时调用的方法
-(BOOL)collectionView:(PSUICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hello,wolrd =%@",indexPath);
    if ([indexPath row] > 4) {
        PayOneCard *oneCard = [[PayOneCard alloc] init];
        [self presentModalViewController:oneCard animated:YES];
    }
    else
    {
        PayCreditCard *value = [[PayCreditCard alloc] init];
        [self presentModalViewController:value animated:YES];
    }
}


//iOS 6.0以下旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        //        return YES;
    }
    return NO;
}


-(BOOL)shouldAutorotate
{
    return NO;
}


//iOS 6.0旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
