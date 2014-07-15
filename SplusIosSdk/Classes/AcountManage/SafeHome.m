//
//  SafeHome.m
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "SafeHome.h"

@interface SafeHome ()

@end

@implementation SafeHome

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popFinish:) name:@"LoginOut_close" object:nil];
    
    _splusArray = [NSArray arrayWithObjects:@"个人资料", @"修改密码", @"绑定手机", nil];
    _splusImageArray = [NSArray arrayWithObjects:@"splus_person_account", @"splus_person_modify_pwd", @"splus_person_binding_phone", nil];
    [self initSafeHome];
    // Do any additional setup after loading the view.
}

-(void)initSafeHome
{
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyAcountBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _splusPayText.text = @"账号安全";
    _splusPayText.font = [UIFont systemFontOfSize:20.0];
    _splusPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 65, 40, 20)];
    _splusTitle.text = @"尊敬的:";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_splusTitle];
    
    _splusUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 60, 20)];
    _splusUserName.text = @"4399_hero";
    _splusUserName.font = [UIFont systemFontOfSize:12.0];
    _splusUserName.textColor = [UIColor orangeColor];
    [self.view addSubview:_splusUserName];
    
    _splusWel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 + 20, 65, 100, 20)];
    _splusWel.font = [UIFont systemFontOfSize:12.0];
    _splusWel.text = @"欢迎来到个人中心";
    [self.view addSubview:_splusWel];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 95, SCREENWIDTH - 20, 160)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    splusEditFrame.userInteractionEnabled = YES;
    [self.view addSubview:splusEditFrame];
    
    _splusTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, SCREENWIDTH - 30, 150)];
    _splusTableView.delegate = self;
    _splusTableView.dataSource = self;
//    _splusTableView.backgroundColor = [UIColor clearColor];
    
    //    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    imageview.contentMode = UIViewContentModeScaleToFill;
    //    [imageview setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    //    [_splusTableView setBackgroundView:imageview];
    
    [splusEditFrame addSubview:_splusTableView];
    
}

-(void)popFinish:(id)sender{
//    [_delegate SplusLoginOutSuccess];
//    [self dismissViewControllerAnimated:NO completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_splusArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AcountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AcountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.headImage.image = [GetImage imagesNamedFromCustomBundle:[_splusImageArray objectAtIndex:[indexPath row]]];
    cell.labelText.text = [_splusArray objectAtIndex:[indexPath row]];
    cell.tailImage.image = [GetImage imagesNamedFromCustomBundle:@"splus_person_arrow"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 2:
        {
            BindPhone *bind = [[BindPhone alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//            [self presentModalViewController:bind animated:YES];
            [self.view addSubview:bind];
        }
            break;
        
        case 1:
        {
            ModifyPwd *modifypwd = [[ModifyPwd alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//            [self presentModalViewController:modifypwd animated:YES];
            [self.view addSubview:modifypwd];
        }
            break;
            
        default:
        {
            HumanResources *huMan = [[HumanResources alloc] init];
            [self presentModalViewController:huMan animated:YES];

        }
        break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 50;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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


//iOS 6.0以下旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
}

-(void)yyCustomClick
{
    AcountWeb *web = [[AcountWeb alloc] init];
    web.payway = 1;
    [self presentModalViewController:web animated:YES];
}

-(void)yyAcountBackClick:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
