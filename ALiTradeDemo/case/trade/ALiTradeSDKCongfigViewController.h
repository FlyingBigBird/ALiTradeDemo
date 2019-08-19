//
//  ALiTradeSDKCongfigViewController.h
//  NBSDK
//
//  Created by com.alibaba on 16/5/31.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#ifndef ALiTradeSDKCongfigViewController_h
#define ALiTradeSDKCongfigViewController_h
#import <UIKit/UIKit.h>

@interface ALiTradeSDKCongfigViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *taokeParamsText;
@property (weak, nonatomic) IBOutlet UITextField *customParamsText;
@property (weak, nonatomic) IBOutlet UISwitch *isSyncForTaoke;
@property (weak, nonatomic) IBOutlet UISwitch *isBindWebview;
@property (weak, nonatomic) IBOutlet UISwitch *isFourceH5;
@property (weak, nonatomic) IBOutlet UISwitch *isUseGlobalTaoke;
@property (weak, nonatomic) IBOutlet UISwitch *isNeedPush;
@property (weak, nonatomic) IBOutlet UISwitch *isUseNativeAlipay;

@property (weak, nonatomic) IBOutlet UISwitch *isUseTaokeParam;
@property (weak, nonatomic) IBOutlet UITextField *backURL;

@end

#endif /* ALiTradeSDKCongfigViewController_h */
