//
//  AppDelegate.m
//  NBdemo
//
//  Created by nieyun on 5/16/16.
//  Copyright © 2016 com.alibaba. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
//#import "AEManager.h"
#ifndef ALIBCTRADEMINISDK
#import "UTMini/AppMonitor.h"
#import<UTMini/AppMonitor.h>
#import <OpenMtopSDK/TBSDKLogUtil.h>
#import <TUnionTradeSDK/TUnionTradeSDK.h>

#endif

#define appkey @"23082328"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MainViewController *mainView=[[MainViewController alloc] init];
    mainView.tabBarItem.title=@"ALiTradeSDK";
    
    UIStoryboard *configStoryboard = [UIStoryboard storyboardWithName:@"ALiTradeSDKCongfigViewController" bundle:nil];
    UIViewController * configView=[configStoryboard instantiateViewControllerWithIdentifier:@"ALiTradeSDKCongfigViewController"];
    configView.tabBarItem.title=@"接口配置";
    
    UIStoryboard *tradeStoryboard = [UIStoryboard storyboardWithName:@"ALiTradeServiceAPIViewController" bundle:nil];
    UIViewController * tradeView=[tradeStoryboard instantiateViewControllerWithIdentifier:@"ALiTradeServiceAPIViewController"];
    tradeView.tabBarItem.title=@"电商接口";

    
    UITabBarController   *tabBarView= [[UITabBarController alloc] init];
    tabBarView.viewControllers=@[mainView,configView,tradeView];
    tabBarView.title=[NSString stringWithFormat:@"ALiSDK %@", AlibcTradeBizSDKVersion];
    tabBarView.edgesForExtendedLayout=UIRectEdgeNone;
    tabBarView.extendedLayoutIncludesOpaqueBars=NO;
    tabBarView.navigationController.navigationBar.translucent=NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tabBarView];
    
    [self.window makeKeyAndVisible];
    
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//开发阶段打开日志开关，方便排查错误信息
    
    [[AlibcTradeSDK sharedInstance] setIsvVersion:@"2.2.2"];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
    
    [AppMonitor turnOnAppMonitorRealtimeDebug:[[NSDictionary alloc]initWithObjectsAndKeys:@"http://muvp.alibaba-inc.com/online/UploadRecords.do", @"debug_api_url",@"ALITrade_IOS_lingfeng_20170228",@"debug_key",nil]];
    
    
    [[AlibcTradeSDK sharedInstance]setTaokeParams:nil];
    [[AlibcTradeSDK sharedInstance] setISVCode:@"nieyun_isv_code"];//设置全局的app标识，在电商模块里等同于isv_cod
    
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果百川处理过会返回YES
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        // 处理其他app跳转到自己的app
    }
    return YES;
}


//IOS9.0 系统新的处理openURL 的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    
    __unused BOOL isHandledByALBBSDK=[[AlibcTradeSDK sharedInstance] application:application openURL:url options:options];//处理其他app跳转到自己的app，如果百川处理过会返回YES
    
    return YES;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
