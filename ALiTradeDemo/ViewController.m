//
//  ViewController.m
//  NBdemo
//
//  Created by nieyun on 5/16/16.
//  Copyright © 2016 com.alibaba. All rights reserved.
//

#import "ViewController.h"

//#import "AlibcConfig.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>
#import "TradeController.h"

@interface MainViewController ()
@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    _loginSuccessCallback=^(ALBBSession *session){
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[session getUser]];
        NSLog(@"%@", tip);
        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
    
    _loginFailedCallback=^(ALBBSession *session, NSError *error){
        NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
        NSLog(@"%@", tip);
        [[MyAlertView alertViewWithTitle:@"登录失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"ALiSDK";
        case 1:
            return @"其他";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainViewController = @"MainViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainViewController];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainViewController];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = self.classNames[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = self.classNames[indexPath.section][indexPath.row];
    if ([className isEqualToString:MODULE_ALiTradeAPIDEMO_CLASS]) {
        
        UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"ALiTradeSDKCongfigViewController" bundle:nil];
        UIViewController * viewcontroller=[Storyboard instantiateViewControllerWithIdentifier:@"ALiTradeSDKCongfigViewController"];
        viewcontroller.title=@"电商交易";
        [self.navigationController pushViewController:viewcontroller animated:YES];
        
    } else if([className isEqualToString:MODULE_ALiTradeAPIDEMO_LOGOUT]){
        
        [[ALBBSDK sharedInstance] logout];
        [[MyAlertView alertViewWithTitle:@"退出登录" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
    else if([className isEqualToString:MODULE_ALiTradeAPIDEMO_LOGIN]){
        if(![[ALBBSession sharedInstance] isLogin]){
            [[ALBBSDK sharedInstance] auth:self successCallback:_loginSuccessCallback failureCallback:_loginFailedCallback];
        }else{
            ALBBSession *session=[ALBBSession sharedInstance];
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
            NSLog(@"%@", tip);
            [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    } 
    else{
        
//        TradeController *subViewController = [[NSClassFromString(className) alloc] init];
//        subViewController.title   = self.titles[indexPath.section][indexPath.row];
//        [self.navigationController pushViewController:(UIViewController*)subViewController animated:NO];
        TradeController *subViewController = [[TradeController alloc] init];
        subViewController.title   = self.titles[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:subViewController animated:NO];
        [subViewController.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.m.taobao.com"]]];
        
    }
    
}


#pragma mark - Initialization

- (void)initTitles
{
    NSArray *basicSDKTitles = @[MODULE_BASIC,
                                MODULE_SWITCHENV];
    //    NSArray *pluginsTitles = self.registeredPluginTitleList;
    NSArray *pluginsTitles = self.pluginTitleList;
    self.titles = [NSArray arrayWithObjects:basicSDKTitles, pluginsTitles, nil];
}

- (void)initClassNames
{
    NSArray *basicSDKClassNames = @[MODULE_BASIC_CLASS,
                                    MODULE_SWITCHENV_CLASS ];
    //    NSArray *pluginsClassNames = self.registeredPluginClassNameList;
    NSArray *pluginsClassNames = self.pluginClassNameList;
    self.classNames = [NSArray arrayWithObjects:basicSDKClassNames, pluginsClassNames, nil];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.title = [NSString stringWithFormat:@"ALiSDK %@", AlibcTradeBizSDKVersion];
        self.pluginTitleList = @[MODULE_ALiTRADELOGIN,MODULE_ALiTRADELOGOUT,MODULE_ALiTRADEDEMO];
        
        self.pluginClassNameList = @[MODULE_ALiTradeAPIDEMO_LOGIN,MODULE_ALiTradeAPIDEMO_LOGOUT,MODULE_ALiTradeAPIDEMO_CLASS];
        //        [self checkRegisteredPlugins];
        [self initTitles];
        [self initClassNames];
    }
    return self;
}

//检查已pod的cases
//-(void)checkRegisteredPlugins{
//    self.registeredPluginTitleList = [[NSMutableArray alloc]init];
//    self.registeredPluginClassNameList = [[NSMutableArray alloc]init];
//
//    for (NSString *pluginClassName in self.pluginClassNameList) {
//        if ([NSClassFromString(pluginClassName) class]) {
//            [self.registeredPluginClassNameList addObject:pluginClassName];
//            NSUInteger index = [self.pluginClassNameList indexOfObject:pluginClassName];
//            [self.registeredPluginTitleList addObject:self.pluginTitleList[index]];
//        }
//    }
//    NSLog(@"已pod的CaseTitle=%@", self.registeredPluginTitleList);
//    NSLog(@"已pod的CaseClassName=%@", self.registeredPluginClassNameList);
//}



@end
