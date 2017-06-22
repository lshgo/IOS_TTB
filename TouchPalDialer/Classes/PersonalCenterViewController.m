//
//  PersonalViewController.m
//  TouchPalDialer
//
//  Created by by.huang on 2017/5/24.
//
//

#import "PersonalCenterViewController.h"
#import "HeaderBar.h"
#import "ColorUtil.h"
#import "UILabel+ContentSize.h"
#import "FreeCallLoginController.h"
#import "ChargeViewController.h"
#import "TouchPalDialerAppDelegate.h"
#import "CommonWebViewController.h"
#import "UserDefaultsManager.h"
#import "DefaultUIAlertViewHandler.h"
#import "IntroduceViewController.h"
#import "YellowPageWebViewController.h"
#import "CTUrl.h"
#import "SeattleFeatureExecutor.h"
#import "Test2ViewController.h"
#import "HandlerWebViewController.h"

@interface PersonalCenterViewController ()

@property(nonatomic, retain) HeaderBar *headerView;

@property(nonatomic, strong) UIView *topView;

@property(strong, nonatomic) UIButton *chargeBtn;

@property(strong, nonatomic) UIButton *historyBtn;

@property(strong, nonatomic) UIButton *questionBtn;

@property(strong, nonatomic) UIButton *loginBtn;

@property(strong, nonatomic) UILabel *minutesLabel;


@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    [self initHeader];
    [self initBody];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"getAccount" object:nil];
}

-(void)updateUserInfo : (NSNotification *)notification
{
    NSString *balance = notification.object;
    _minutesLabel.text = balance;
}


-(void)initHeader
{
    HeaderBar *headerBar = [[HeaderBar alloc] initHeaderBar];
    [headerBar setSkinStyleWithHost:self forStyle:@"defaultHeaderView_style"];
    [self.view addSubview:headerBar];
    self.headerView = headerBar;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((TPScreenWidth()-120)/2, TPHeaderBarHeightDiff(), 120, 45)];
    [titleLabel setSkinStyleWithHost:self forStyle:@"defaultUILabel_style"];
    titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_2_5];
    titleLabel.text = @"个人中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:titleLabel];
}


-(void)initBody
{
    [self initTopView];
    
    _chargeBtn = [[UIButton alloc]init];
    _chargeBtn.frame = CGRectMake(0,_topView.tp_y + _topView.tp_height + 10, TPScreenWidth(), 60);
    _chargeBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chargeBtn];
    [self createItemButton:@"立即充值" image:[UIImage imageNamed:@"ic_charge"] root:_chargeBtn];
    
    _historyBtn = [[UIButton alloc]init];
    _historyBtn.frame = CGRectMake(0,_chargeBtn.tp_y + _chargeBtn.tp_height + 10, TPScreenWidth(), 60);
    _historyBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_historyBtn];
    [self createItemButton:@"充值记录查询" image:[UIImage imageNamed:@"ic_history"] root:_historyBtn];
    
    
    _questionBtn = [[UIButton alloc]init];
    _questionBtn.frame = CGRectMake(0,_historyBtn.tp_y + _historyBtn.tp_height + 10, TPScreenWidth(), 60);
    _questionBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_questionBtn];
    [self createItemButton:@"费率说明" image:[UIImage imageNamed:@"ic_question"] root:_questionBtn];
    
    _loginBtn = [[UIButton alloc]init];
    _loginBtn.frame = CGRectMake(0,_questionBtn.tp_y + _questionBtn.tp_height + 10, TPScreenWidth(), 60);
    _loginBtn.backgroundColor = [UIColor whiteColor];
    
    if([UserDefaultsManager boolValueForKey:TOUCHPAL_USER_HAS_LOGIN]){
        [_loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [_loginBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
    }
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_loginBtn];
    
    
    [_chargeBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_historyBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_questionBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)initTopView
{
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, 45 + TPHeaderBarHeightDiff(), TPScreenWidth(), 160);
    _topView.backgroundColor = [ColorUtil colorWithHexString:@"#3695ED"];
    [self.view addSubview:_topView];
    
    [self createCircleView:140 backgroudColor: [ColorUtil colorWithHexString:@"#58aeff" alpha:103.0f/255.0f] view:_topView];
    [self createCircleView:120 backgroudColor: [ColorUtil colorWithHexString:@"#88c6ff" alpha:1.0f] view:_topView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"剩余分钟数";
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake((TPScreenWidth() - label.contentSize.width ) /2, 80 - label.contentSize.height  - 10, label.contentSize.width, label.contentSize.height);
    [_topView addSubview:label];
    
    
    _minutesLabel = [[UILabel alloc]init];
    _minutesLabel.font = [UIFont systemFontOfSize:20.0f];
    _minutesLabel.textColor = [UIColor whiteColor];
    _minutesLabel.textAlignment = NSTextAlignmentCenter;
    
    _minutesLabel.text = [NSString stringWithFormat:@"%d",[UserDefaultsManager intValueForKey:@"voip_account_balance"]];
    _minutesLabel.frame = CGRectMake(0, 80 , TPScreenWidth(), 30);
    [_topView addSubview:_minutesLabel];
}


-(void)createCircleView : (int)width backgroudColor : (UIColor *)color view : (UIView *)topView
{
    UIView *outCircleView = [[UIView alloc]init];
    outCircleView.frame = CGRectMake((TPScreenWidth() - width)/2,  (160-width)/2, width, width);
    outCircleView.layer.cornerRadius = width/2;
    outCircleView.layer.masksToBounds = YES;
    outCircleView.backgroundColor = color;
    [topView addSubview:outCircleView];
}


-(void)createItemButton : (NSString *)title image : (UIImage *)image root : (UIButton *)button
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.frame = CGRectMake(20, 15, 30, 30);
    [button addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.frame = CGRectMake(60, (60 -label.contentSize.height)/2, label.contentSize.width, label.contentSize.height);
    [button addSubview:label];
    
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    arrowImageView.image = [UIImage imageNamed:@"ic_arrow"];
    arrowImageView.frame = CGRectMake(TPScreenWidth()-50, 20, 20, 20);
    [button addSubview:arrowImageView];
    
}



-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(![UserDefaultsManager boolValueForKey:TOUCHPAL_USER_HAS_LOGIN]){
         [LoginController checkLoginWithDelegate:[FreeCallLoginController withOrigin:@"personal_center_head"] ];
        
        return;
    }

    if(button == _chargeBtn){
        [TouchPalDialerAppDelegate pushViewController:[[ChargeViewController alloc]init] animated:YES];
        
    }else if(button == _historyBtn){
        
        [TouchPalDialerAppDelegate pushViewController:[[Test2ViewController alloc]init] animated:YES];
//        YellowPageWebViewController *controller = [[YellowPageWebViewController alloc] init];
//        NSString *token = [SeattleFeatureExecutor getToken];
//        NSString *url = [NSString stringWithFormat:@"http://search.cootekservice.com/page_v3/activity_recharge_price.html?_token=%@", token];
//        controller.url_string = url;
//        controller.web_title = NSLocalizedString(@"personal_center_setting_coupon", @"");
//        controller.view.frame = CGRectMake(0, 0, TPScreenWidth(), TPAppFrameHeight()-TAB_BAR_HEIGHT+TPHeaderBarHeightDiff());
//        [[TouchPalDialerAppDelegate naviController] pushViewController:controller animated:YES];
        
    }else if(button == _questionBtn){
        [TouchPalDialerAppDelegate pushViewController:[[IntroduceViewController alloc]init] animated:YES];
        
    }else if(button == _loginBtn){
        [DefaultUIAlertViewHandler showAlertViewWithTitle:NSLocalizedString(@"personal_center_logout_hint", @"") message:nil cancelTitle:NSLocalizedString(@"personal_center_logout_cancel", @"") okTitle:NSLocalizedString(@"personal_center_logout_confirm", @"") okButtonActionBlock:^ {
            [LoginController removeLoginDefaultKeys];
            [_loginBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
        } cancelActionBlock:^{
            
        }];
    }
}



@end
