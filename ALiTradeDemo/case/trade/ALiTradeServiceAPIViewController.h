//
//  ALiTradeServiceAPIViewController.h
//  NBSDK
//
//  Created by com.alibaba on 16/5/31.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#ifndef ALiTradeServiceAPIViewController_h
#define ALiTradeServiceAPIViewController_h

#import <UIKit/UIKit.h>
#import "ALiTradeServiceAPIViewController.h"
#import "ALiTradeTestData.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>

#import "MyAlertView.h"

#import "ALiTradeWebViewController.h"


@interface ALiTradeServiceAPIViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *pageUrl;
@property (weak, nonatomic) IBOutlet UITextField *requestUrl;

@property (weak, nonatomic) IBOutlet UITextField *itemID;
@property (weak, nonatomic) IBOutlet UITextField *MiniItemID;
@property (weak, nonatomic) IBOutlet UITextField *shopID;
@property (weak, nonatomic) IBOutlet UITextField *add2CartItemID;

@property (weak, nonatomic) IBOutlet UITextField *myOrderStatus;
@property (weak, nonatomic) IBOutlet UISwitch *isAllOrder;

@property (weak, nonatomic) IBOutlet UISwitch *isUserRealid;

@property (weak, nonatomic) IBOutlet UISegmentedControl *itemTypeSeg;

//@property (retain, nonatomic) IBOutlet UISegmentedControl *itemTypeSeg;
@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;

-(AlibcOpenType )openType;
- (void)OpenByPage:(id<AlibcTradePage>)page;
-(NSDictionary *)customParam;
-(AlibcTradeTaokeParams*)taokeParam;


@end
#endif /* ALiTradeServiceAPIViewController_h */
