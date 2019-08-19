//
//  SelectEnvViewController.h
//  TaeSDKSample
//
//  Created by com.alibaba on 14-9-23.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchEnvViewController : UIViewController<UIApplicationDelegate>

@property (strong, nonatomic) UILabel *lblCurrentEnv;
@property (strong, nonatomic) UIButton *btnSelectEnvRelease;
@property (strong, nonatomic) UIButton *btnSelectEnvPreRelease;
@property (strong, nonatomic) UIButton *btnSelectEnvDaily;
@property (strong, nonatomic) UIButton *btnSelectEnvSandbox;
@end
