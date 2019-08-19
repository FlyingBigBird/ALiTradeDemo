//
//  SelectEnvViewController.m
//  TaeSDKSample
//
//  Created by com.alibaba on 14-9-23.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import "SwitchEnvViewController.h"
//#import "ALiSDK+Reset.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>

#import "MyAlertView.h"

//#import <AlibcTradeCommonSDK.h>

@interface SwitchEnvViewController ()

@end

@implementation SwitchEnvViewController

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    switch ([[NSUserDefaults standardUserDefaults]integerForKey:@"Environnement"]) {
        case 0:
            [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];

            break;
        case 1:
            [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentPreRelease];
            break;
        case 2:
            [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentDaily];
            break;
        default:
            [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentNone];

            break;
    }
    return YES;
}

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
    // Do any additional setup after loading the view.
    _lblCurrentEnv = [[UILabel alloc]init];
    _lblCurrentEnv.font = [UIFont fontWithName:@"Arial" size:20];
    _lblCurrentEnv.frame = CGRectMake((self.view.bounds.size.width-150)/2, 100, 150, 40);
    [self.view addSubview:_lblCurrentEnv];
    [self updateCurrentEnv];
    [self addButton:_btnSelectEnvRelease offsetY:200 initMessage:@"切换为线上环境" target:@selector(changeEnv2Release)];
    [self addButton:_btnSelectEnvPreRelease offsetY:260 initMessage:@"切换为预发环境" target:@selector(changeEnv2PreRelease)];
    [self addButton:_btnSelectEnvDaily offsetY:320 initMessage:@"切换为日常环境" target:@selector(changeEnv2Daily)];
    [self addButton:_btnSelectEnvSandbox offsetY:380 initMessage:@"切换为沙箱环境" target:@selector(changeEnv2Sandbox)];
}

-(void)changeEnv2Release{
    [self saveEnv:0];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    [self showEnv:0];
}

-(void)changeEnv2PreRelease{
    [self saveEnv:1];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentPreRelease];
    [self showEnv:1];
}

-(void)changeEnv2Daily{
    [self saveEnv:2];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentDaily];
    [self showEnv:2];

}

-(void)changeEnv2Sandbox{
    [self saveEnv:3];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentNone];
    [self showEnv:3];
}

-(void)saveEnv:(NSInteger)TaeSDKEnvironment{
    [[NSUserDefaults standardUserDefaults]setInteger:TaeSDKEnvironment forKey:@"Environnement"];
}

-(void)showEnv:(NSInteger)Env{
    NSString *tip=[NSString stringWithFormat:@""];
    switch (Env) {
        case 0:
          [_lblCurrentEnv setText:@"当前环境：线上"];
          tip=@"当前环境：线上";
        break;
        case 1:
          [_lblCurrentEnv setText:@"当前环境：预发"];
          tip=@"当前环境：预发";
        break;
        case 2:
          [_lblCurrentEnv setText:@"当前环境：日常"];
          tip=@"当前环境：日常";
        break;
        case 3:
          [_lblCurrentEnv setText:@"当前环境：沙箱"];
          tip=@"当前环境：沙箱";
        break;
            
        default:
        break;
                }
    [[MyAlertView alertViewWithTitle:@"环境切换成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
}

-(void)updateCurrentEnv{
    #ifndef ALIBCTRADEMINISDK
    switch ([AlibcTradeCommonSDK getEnv]) {
    #else
    switch ([AlibcTradeMiniCommonSDK getEnv]) {
    #endif
        case AlibcEnvironmentRelease:
            [_lblCurrentEnv setText:@"当前环境：线上"];
            break;
        case AlibcEnvironmentPreRelease:
            [_lblCurrentEnv setText:@"当前环境：预发"];
            break;
        case AlibcEnvironmentDaily:
            [_lblCurrentEnv setText:@"当前环境：日常"];
            break;
        case AlibcEnvironmentNone:
            [_lblCurrentEnv setText:@"当前环境：沙箱"];
            break;
            
        default:
            break;
    }
}

- (void)addButton:(UIButton*) button
          offsetY:(NSInteger) offsetY
      initMessage:(NSString*) initMessage
           target:(SEL)target{
    CGFloat width = self.view.bounds.size.width;
    button = [[UIButton alloc]initWithFrame:CGRectMake((width-160)/2, offsetY, 160, 40)];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10.0];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:initMessage forState:UIControlStateNormal];
    [button addTarget:self action:target forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
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
