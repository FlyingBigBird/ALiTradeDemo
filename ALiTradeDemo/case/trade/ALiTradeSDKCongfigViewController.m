//
//  ALiTradeSDKCongfigViewController.m
//  NBSDK
//
//  Created by com.alibaba on 16/5/31.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeSDKCongfigViewController.h"
#import "ALiTradeParamConfigViewController.h"
#import "ALiTradeSDKShareParam.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
//#import "ALiWebViewService.h"

#import "ALiTradeWebViewController.h"

@interface ALiTradeSDKCongfigViewController()

@end

@implementation ALiTradeSDKCongfigViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[AlibcTradeSDK sharedInstance] setIsSyncForTaoke:[_isSyncForTaoke isOn]];
    [[AlibcTradeSDK sharedInstance] setIsForceH5:[_isFourceH5 isOn]];
    [[AlibcTradeSDK sharedInstance] setTaokeParams:nil];
    [[AlibcTradeSDK sharedInstance] setShouldUseAlipayNative:[_isUseNativeAlipay isOn]];
    [ALiTradeSDKShareParam sharedInstance].isBindWebview=[_isBindWebview isOn];
    [ALiTradeSDKShareParam sharedInstance].isNeedPush=[_isNeedPush isOn];
    [ALiTradeSDKShareParam sharedInstance].isUseTaokeParam=[_isUseTaokeParam isOn];
    _backURL.text=[NSString stringWithFormat:@"%@",[ALiTradeSDKShareParam sharedInstance].backUrl];

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _taokeParamsText.text=[NSString stringWithFormat:@"%@",[ALiTradeSDKShareParam sharedInstance].taoKeParams];
    _customParamsText.text=[NSString stringWithFormat:@"%@",[ALiTradeSDKShareParam sharedInstance].customParams];
//     _backURL.text=[NSString stringWithFormat:@"%@",[ALiTradeSDKShareParam sharedInstance].backUrl];
}
//打开自定义参数编辑页
- (IBAction)showCustomParamsEdit:(id)sender {
    [ALiTradeSDKShareParam sharedInstance].externParams=[ALiTradeSDKShareParam sharedInstance].customParams;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ALiTradeParamConfigViewController" bundle:nil];
    UIViewController * viewcontroller=[storyboard instantiateViewControllerWithIdentifier:@"ALiTradeParamConfigViewController"];
    viewcontroller.title=@"业务参数编辑";
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

//打开淘客参数编辑页
- (IBAction)showTaoKeParamsEdit:(id)sender {
    [ALiTradeSDKShareParam sharedInstance].externParams=[ALiTradeSDKShareParam sharedInstance].taoKeParams;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ALiTradeParamConfigViewController" bundle:nil];
    UIViewController * viewcontroller=[storyboard instantiateViewControllerWithIdentifier:@"ALiTradeParamConfigViewController"];
    viewcontroller.title=@"淘客参数编辑";
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
- (IBAction)showALiTradeServiceAPIDemo:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ALiTradeServiceAPIViewController" bundle:nil];
    UIViewController * viewcontroller=[storyboard instantiateViewControllerWithIdentifier:@"ALiTradeServiceAPIViewController"];
    viewcontroller.title=@"电商接口";
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (IBAction)TextField_DidEndOnExit:(id)sender {
    // 隐藏键盘.
    [sender resignFirstResponder];
}

///接口参数 打开页面的方式
- (IBAction)changeOpenType:(UISegmentedControl *)sender {
    [ALiTradeSDKShareParam sharedInstance].openType=[sender selectedSegmentIndex];
}
//接口参数  使用手淘还是天猫打开native
- (IBAction)changeLinkKey:(id)sender {
    [ALiTradeSDKShareParam sharedInstance].linkKey=[sender selectedSegmentIndex];
}

- (IBAction)changeNativeFailMode:(id)sender {
    [ALiTradeSDKShareParam sharedInstance].NativeFailMode=[sender selectedSegmentIndex];
}

//接口测试   是否使用push方式打开
- (IBAction)isNeedPush:(UISwitch *)sender {
    [ALiTradeSDKShareParam sharedInstance].isNeedPush=[sender isOn];
}
- (IBAction)isBindWebview:(UISwitch *)sender {
    [ALiTradeSDKShareParam sharedInstance].isBindWebview=[sender isOn];
}
//全局参数  是否使用native支付宝
- (IBAction)isUseNativeAlipay:(id)sender {
    [[AlibcTradeSDK sharedInstance] setShouldUseAlipayNative:[sender isOn]];
}

- (IBAction)setIsForceH5:(UISwitch *)sender {
    BOOL isFouceH5=[sender isOn];
    [[AlibcTradeSDK sharedInstance] setIsForceH5:isFouceH5];
}
- (IBAction)backUrlChange:(UITextField *)sender {
    [ALiTradeSDKShareParam sharedInstance].backUrl=sender.text;
    
}

//全局参数  同步还是异步淘客打点方式
- (IBAction)isSyncForTaoke:(UISwitch *)sender {
    BOOL isSync=[sender isOn];
    [[AlibcTradeSDK sharedInstance] setIsSyncForTaoke:isSync];
}
// 全局参数  是否使用全局淘客参数
- (IBAction)isUserGlobalTaokeParams:(UISwitch *)sender {
    if (sender.isOn) {
        AlibcTradeTaokeParams *taokeParam = [[AlibcTradeTaokeParams alloc] init];
        taokeParam.pid =[[ALiTradeSDKShareParam sharedInstance].globalTaoKeParams objectForKey:@"pid"];
        taokeParam.subPid = [[ALiTradeSDKShareParam sharedInstance].globalTaoKeParams objectForKey:@"subPid"];
        taokeParam.unionId = [[ALiTradeSDKShareParam sharedInstance].globalTaoKeParams objectForKey:@"unionId"];
        taokeParam.adzoneId = [[ALiTradeSDKShareParam sharedInstance].globalTaoKeParams objectForKey:@"adzoneId"];
        
        [[AlibcTradeSDK sharedInstance]setTaokeParams:taokeParam];

    } else {
        [[AlibcTradeSDK sharedInstance]setTaokeParams:nil];
    }
}

- (IBAction)isUseTaokeParam:(UISwitch *)sender {
    [ALiTradeSDKShareParam sharedInstance].isUseTaokeParam=[sender isOn];
}

@end
