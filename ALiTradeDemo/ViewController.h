//
//  ViewController.h
//  NBdemo
//
//  Created by nieyun on 5/16/16.
//  Copyright © 2016 com.alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MODULE_BASIC                @"基础SDK"
#define MODULE_SWITCHENV            @"环境切换"


#define MODULE_ALiTRADELOGIN        @"淘宝登录"
#define MODULE_ALiTRADELOGOUT       @"退出登录"
#define MODULE_ALiTRADEDEMO         @"电商交易"



#define MODULE_BASIC_CLASS                @"ALiBasicViewController"
#define MODULE_SWITCHENV_CLASS            @"SwitchEnvViewController"

#define MODULE_ALiTradeAPIDEMO_LOGIN      @"ALiTradeSDKLoginViewController"
#define MODULE_ALiTradeAPIDEMO_LOGOUT     @"ALiTradeSDKLogoutViewController"
#define MODULE_ALiTradeAPIDEMO_CLASS      @"ALiTradeSDKCongfigViewController"
#define MODULE_ALiAuthDEMO_CLASS          @"ALiAuthServiceViewController"




@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classNames;

@property (nonatomic, strong) NSArray *pluginTitleList;
@property (nonatomic, strong) NSArray *pluginClassNameList;
@property (nonatomic, strong) NSMutableArray *registeredPluginTitleList;
@property (nonatomic, strong) NSMutableArray *registeredPluginClassNameList;

@end

