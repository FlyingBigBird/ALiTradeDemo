//
//  ALiTradeServiceAPIViewController.m
//  NBSDK
//
//  Created by com.alibaba on 16/5/31.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeServiceAPIViewController.h"
#import "ALiTradeTestData.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import "ALiTradeSDKShareParam.h"
#import "UIKit/UIKit.h"
//#import "AlibcTradeError.h"

//#import <AlibcTradeCommonSDK.h>

@interface ALiTradeServiceAPIViewController()
@property (nonatomic) OneSDKItemType itemType;
@property (nonatomic, strong) ALiTradeTestData *tradeTestData;
@end


@implementation ALiTradeServiceAPIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initToolBar];
    _tradeTestData = [[ALiTradeTestData alloc] init];
    self.itemType = OneSDKItemType_TAOBAO1;
    [self changeItemTypeAction:OneSDKItemType_TAOBAO1];
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        if(tradeProcessResult.result ==AlibcTradeResultTypePaySuccess){
            NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@\n，失败的订单%@\n",[tradeProcessResult payResult].paySuccessOrders,[tradeProcessResult payResult].payFailedOrders];
            [[MyAlertView alertViewWithTitle:@"交易成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }else if(tradeProcessResult.result==AlibcTradeResultTypeAddCard){
            [[MyAlertView alertViewWithTitle:@"加入购物车" message:@"加入成功" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    };
    _onTradeFailure=^(NSError *error){
//        退出交易流程
        if (error.code==AlibcErrorCancelled) {
            return ;
        }
        NSDictionary *infor=[error userInfo];
        NSArray*  orderid=[infor objectForKey:@"orderIdList"];
        NSString *tip=[NSString stringWithFormat:@"交易失败:\n订单号\n%@",orderid];
        [[MyAlertView alertViewWithTitle:@"交易失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };    
}

#pragma mark - Initialization
//- (void)initToolBar {
//    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                                  target:self
//                                                                                  action:nil];
//    //数据复用
//    //Item、Order、Cart数据为淘宝宝贝1，淘宝宝贝2、天猫宝贝1、天猫宝贝2
//    //Promotion优惠券数据为shop方式（sellernick）、auction方式（混淆id）
//   _itemTypeSeg = [[UISegmentedControl alloc] initWithItems:
//                                          [NSArray arrayWithObjects:
//                                           @"淘宝",
//                                           @"专享价",
//                                           @"商超",
//                                           @"天猫",
//                                           nil]];
//    _itemTypeSeg.selectedSegmentIndex  = self.itemType;
//    [_itemTypeSeg addTarget:self action:@selector(changeItemTypeAction:) forControlEvents:UIControlEventValueChanged];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_itemTypeSeg];
//    
//    self.toolbarItems = [NSArray arrayWithObjects:flexibleItem, item, flexibleItem, nil];
//}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setToolbarHidden:NO animated:animated];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setToolbarHidden:YES animated:animated];
//}

- (IBAction)TextField_DidEndOnExit:(id)sender {
    // 隐藏键盘.
    [sender resignFirstResponder];
}
-(AlibcTradeTaokeParams*)taokeParam{
    if ([ALiTradeSDKShareParam sharedInstance].isUseTaokeParam) {
        AlibcTradeTaokeParams *taoke = [[AlibcTradeTaokeParams alloc] init];
        taoke.pid =[[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"pid"];
        taoke.subPid = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"subPid"];
        taoke.unionId = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"unionId"];
        taoke.adzoneId = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"adzoneId"];
        taoke.extParams = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"extParams"];
        return taoke;
    } else {
        return nil;
    }
    
}
-(NSDictionary *)customParam{
    NSDictionary *customParam=[NSDictionary dictionaryWithDictionary:[ALiTradeSDKShareParam sharedInstance].customParams];
    return customParam; 
    
}
-(AlibcOpenType)openType{
    
    AlibcOpenType openType=AlibcOpenTypeAuto;
    switch ([ALiTradeSDKShareParam sharedInstance].openType) {
        case 0:
            openType=AlibcOpenTypeAuto;
            break;
        case 1:
            openType=AlibcOpenTypeNative;
            break;
        case 2:
            openType=AlibcOpenTypeH5;
            break;
            
        default:
            break;
    }
    return openType;
}
-(AlibcNativeFailMode )NativeFailMode{
    AlibcNativeFailMode openType=AlibcNativeFailModeJumpH5;
    switch ([ALiTradeSDKShareParam sharedInstance].NativeFailMode) {
        case 0:
            openType=AlibcNativeFailModeJumpH5;
            break;
        case 1:
            openType=AlibcNativeFailModeJumpDownloadPage;
            break;
        case 2:
            openType=AlibcNativeFailModeJumpBrowser;
            break;
        case 3:
            openType=AlibcNativeFailModeNone;
            break;
        default:
            break;
    }
    return openType;
    
}
-(NSString*)schemeType{
  NSString*  linkKey=@"tmall_scheme";
    switch ([ALiTradeSDKShareParam sharedInstance].linkKey) {
        case 0:
            linkKey=@"taobao_scheme";
            break;
        case 1:
            linkKey=@"tmall_scheme";
            break;
        default:
            break;
    }
    return linkKey;

}


- (IBAction)openUrl:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory page:_pageUrl.text];
    [self OpenByPage:page];
   
}
- (IBAction)openUrlWithRequest:(id)sender {
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_requestUrl.text]];
    id<AlibcTradePage> page = [AlibcTradePageFactory requestPage:request];
    [self OpenByPage:page];
}

- (IBAction)openItemDetail:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:_itemID.text];
    [self OpenByPage:page];
}

- (IBAction)openMiniItemDetail:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory itemMiniDetailPage:_MiniItemID.text];
    [self OpenByPage:page];
}

- (IBAction)openShop:(id)sender {
    id<AlibcTradePage> page= [AlibcTradePageFactory shopPage:_shopID.text];
    [self OpenByPage:page];
    
}
- (IBAction)addItemToCart:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory addCartPage:_add2CartItemID.text];
    [self OpenByPage:page];
}

- (IBAction)openOrder:(id)sender {
     BOOL isAllOrder=[_isAllOrder isOn];
    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:[_myOrderStatus.text integerValue] isAllOrder:!isAllOrder];
    [self OpenByPage:page];
}
- (IBAction)openCart:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    [self OpenByPage:page];

}

- (void)OpenByPage:(id<AlibcTradePage>)page
{
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [self openType];
//    showParam.backUrl=@"tbopen23082328:https://h5.m.taobao.com";
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    BOOL isNeedPush=[ALiTradeSDKShareParam sharedInstance].isNeedPush;
    BOOL isBindWebview=[ALiTradeSDKShareParam sharedInstance].isBindWebview;
    showParam.isNeedPush=isNeedPush;
    showParam.nativeFailMode=[self NativeFailMode];

//    showParam.linkKey = @"tmall_scheme";//暂时拉起天猫
    showParam.linkKey=[self schemeType];
//    showParam.linkKey = @"dingding_scheme";//暂时拉起天猫

    if (isBindWebview) {
        
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:view webView:view.webView page:page showParams:showParam taoKeParams:[self taokeParam] trackParam:[self customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
        if (res == 1) {
            [self.navigationController pushViewController:view animated:YES];
        }
    } else {
        if (isNeedPush) {
            [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController page:page showParams:showParam taoKeParams:[self taokeParam] trackParam:[self customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        } else {
            [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:[self taokeParam] trackParam:[self customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        }

    }
}
- (IBAction)isUserRealItemID:(UISwitch *)sender {
    [self changeItemTypeAction:_itemTypeSeg];
}


- (void)changeItemTypeAction:(UISegmentedControl *)sender {
    
    self.itemType = sender.selectedSegmentIndex;
    ALiTradeTestData *data = [[ALiTradeTestData alloc]init];
//    
    if(([AlibcTradeCommonSDK getEnv] == AlibcEnvironmentDaily) ||( [AlibcTradeCommonSDK getEnv] == AlibcEnvironmentDaily)){
        switch (self.itemType) {
            case OneSDKItemType_TAOBAO1:
            {
//                data.pageUrl = ([[AlibcTradeSDK sharedInstance] getEnv] == AlibcEnvironmentDaily)? DAILYURL_TB1:SANDBOXURL_TB1;
                data.pageUrl =DAILYURL_TB1;
                data.realItemId = DAILYREALITEMID_TB1;
                data.itemType = DAILYITEMTYPE_TB1;
                data.openItemId1 = DAILYITEMID_TB1;
                data.skuId1 = DAILYSKUID_TB1;
                data.openItemId2 = DAILYITEMID_TB2;
                data.skuId2 = DAILYSKUID_TB2;
                data.promotiontype = @"shop";
                data.promotionparam = DAILYSELLNICK;
                break;
            }
            case OneSDKItemType_TAOBAO2:
            {
//                data.pageUrl = ([[AlibcTradeSDK sharedInstance] getEnv] == AlibcEnvironmentDaily)? DAILYURL_TB2:SANDBOXURL_TB2;
                data.pageUrl =DAILYURL_TB2;
                data.realItemId = DAILYREALITEMID_TB2;
                data.itemType = DAILYITEMTYPE_TB2;
                data.openItemId1 = DAILYITEMID_TB2;
                data.skuId1 = DAILYSKUID_TB2;
                data.openItemId2 = DAILYITEMID_TB1;
                data.skuId2 = DAILYSKUID_TB1;
                data.promotiontype = @"shop";
                data.promotionparam = DAILYSELLNICK;
                break;
            }
            case OneSDKItemType_TMALL1:
            {
//                data.pageUrl = ([[AlibcTradeSDK sharedInstance] getEnv] == AlibcEnvironmentDaily)? DAILYURL_TM1:SANDBOXURL_TM1;
                data.pageUrl =DAILYURL_TM1;
                data.realItemId = DAILYREALITEMID_TM1;
                data.itemType = DAILYITEMTYPE_TM1;
                data.openItemId1 = DAILYITEMID_TM1;
                data.skuId1 = DAILYSKUID_TM1;
                data.openItemId2 = DAILYITEMID_TM2;
                data.skuId2 = DAILYSKUID_TM2;
                data.promotiontype = @"auction";
                data.promotionparam = DAILYITID;
                break;
            }
            case OneSDKItemType_TMALL2:
            {
//                data.pageUrl = ([[AlibcTradeSDK sharedInstance] getEnv] == AlibcEnvironmentDaily)? DAILYURL_TM2:SANDBOXURL_TM2;
                data.pageUrl =DAILYURL_TM2;
                data.realItemId = DAILYREALITEMID_TM2;
                data.itemType = DAILYITEMTYPE_TM2;
                data.openItemId1 = DAILYITEMID_TM2;
                data.skuId1 = DAILYSKUID_TM2;
                data.openItemId2 = DAILYITEMID_TM1;
                data.skuId2 = DAILYSKUID_TM1;
                data.promotiontype = @"auction";
                data.promotionparam = DAILYITID;
                break;
            }
            case OneSDKItemType_JSBRIDGE:
            {
                data.pageUrl =@"http://h5.waptest.taobao.com/src/bcjsbridge.html";
                data.realItemId = DAILYREALITEMID_TM2;
                data.itemType = DAILYITEMTYPE_TM2;
                data.openItemId1 = DAILYITEMID_TM2;
                data.skuId1 = DAILYSKUID_TM2;
                data.openItemId2 = DAILYITEMID_TM1;
                data.skuId2 = DAILYSKUID_TM1;
                data.promotiontype = @"auction";
                data.promotionparam = DAILYITID;
                break;

            }
            default:
                break;
        }
        data.taoKePid = DAILYTAOKEPID;
        data.taoKeUnionId = DAILYTAOKEUNIONID;
        if (data.taoKePid!=nil) {
            [ALiTradeSDKShareParam sharedInstance].taoKeParams[@"pid"] = data.taoKePid;
            
        }
        if (data.taoKeUnionId!=nil) {
            [ALiTradeSDKShareParam sharedInstance].taoKeParams[@"unionId"] = data.taoKeUnionId;
        }
        data.eticketorderid = DAILYORDERID;
    }
    //线上、预发环境
    else if(([AlibcTradeCommonSDK getEnv] == AlibcEnvironmentPreRelease) || ([AlibcTradeCommonSDK getEnv] == AlibcEnvironmentRelease)){
        switch (self.itemType) {
            case OneSDKItemType_TAOBAO1:
            {
//                data.pageUrl = (TaeSDKCurrentEnvironment() == TaeSDKEnvironmentRelease)? RELEASEURL_TB1:PRERELEASEURL_TB1;

                data.pageUrl =RELEASEURL_TB1;
                data.taokePageUrl=RELEASETAOKEURL_TB1;
                data.realItemId = RELEASEREALITEMID_TB1;
                data.shopId=RELEASESHOPID_TB1;
                data.itemType = RELEASEITEMTYPE_TB1;
                data.openItemId1 = RELEASEITEMID_TB1;
                data.skuId1 = RELEASESKUID_TB1;
                data.openItemId2 = RELEASEITEMID_TB2;
                data.skuId2 = RELEASESKUID_TB2;
                data.promotiontype = @"shop";
                data.promotionparam = RELEASESELLNICK;
                break;
            }
            case OneSDKItemType_TAOBAO2:
            {
//                data.pageUrl = (TaeSDKCurrentEnvironment() == TaeSDKEnvironmentRelease)? RELEASEURL_TB2:PRERELEASEURL_TB2;
                data.pageUrl =RELEASEURL_TB2;
                data.taokePageUrl=RELEASETAOKEURL_TB2;
                data.realItemId = RELEASEREALITEMID_TB2;
                data.shopId=RELEASESHOPID_TB2;
                data.itemType = RELEASEITEMTYPE_TB2;
                data.openItemId1 = RELEASEITEMID_TB2;
                data.skuId1 = RELEASESKUID_TB2;
                data.openItemId2 = RELEASEITEMID_TB1;
                data.skuId2 = RELEASESKUID_TB1;
                data.promotiontype = @"shop";
                data.promotionparam = RELEASESELLNICK;
                
                break;
            }
            case OneSDKItemType_TMALL1:
            {
//                data.pageUrl = (TaeSDKCurrentEnvironment() == TaeSDKEnvironmentRelease)? RELEASEURL_TM1:PRERELEASEURL_TM1;
                data.pageUrl =RELEASEURL_TM1;

                data.taokePageUrl=RELEASETAOKEURL_TM1;

                data.realItemId = RELEASEREALITEMID_TM1;
                data.shopId=RELEASESHOPID_TM1;

                data.itemType = RELEASEITEMTYPE_TM1;
                data.openItemId1 = RELEASEITEMID_TM1;
                
                data.skuId1 = RELEASESKUID_TM1;
                data.openItemId2 = RELEASEITEMID_TM2;
                data.skuId2 = RELEASESKUID_TM2;
                data.promotiontype = @"auction";
                data.promotionparam = RELEASEITID;
                break;
            }
            case OneSDKItemType_TMALL2:
            {
//                data.pageUrl = (TaeSDKCurrentEnvironment() == TaeSDKEnvironmentRelease)? RELEASEURL_TM2:PRERELEASEURL_TM2;
                data.pageUrl =RELEASEURL_TM2;
                data.taokePageUrl=RELEASETAOKEURL_TM2;
                data.realItemId = RELEASEREALITEMID_TM2;
                data.shopId=RELEASESHOPID_TM2;
                data.itemType = RELEASEITEMTYPE_TM2;
                data.openItemId1 = RELEASEITEMID_TM2;
                data.skuId1 = RELEASESKUID_TM2;
                data.openItemId2 = RELEASEITEMID_TM1;
                data.skuId2 = RELEASESKUID_TM1;
                data.promotiontype = @"auction";
                data.promotionparam = RELEASEITID;
                break;
            }
            case OneSDKItemType_JSBRIDGE:
            {
                data.pageUrl =@"http://h5.waptest.taobao.com/src/bcjsbridge.html";
                data.taokePageUrl=@"https://h5.waptest.taobao.com/src/aplus2ut.html";
                data.realItemId = DAILYREALITEMID_TM2;
                data.itemType = DAILYITEMTYPE_TM2;
                data.openItemId1 = DAILYITEMID_TM2;
                data.skuId1 = DAILYSKUID_TM2;
                data.openItemId2 = DAILYITEMID_TM1;
                data.skuId2 = DAILYSKUID_TM1;
                data.promotiontype = @"auction";
                data.promotionparam = DAILYITID;
                break;
                
            }
            default:
                break;
        }
        /*
        data.taoKePid = RELEASETAOKEPID;
        data.taoKeUnionId = RELEASETAOKEUNIONID;
        if (data.taoKePid!=nil) {
            [ALiTradeSDKShareParam sharedInstance].taoKeParams[@"pid"] = data.taoKePid;
        }
        if (data.taoKeUnionId!=nil) {
            [ALiTradeSDKShareParam sharedInstance].taoKeParams[@"unionId"] = data.taoKeUnionId;
        }
         */
        data.eticketorderid = RELEASEORDERID;
    }
    
    if ([_isUserRealid isOn]) {
        _itemID.text=data.realItemId;
        _MiniItemID.text=data.realItemId;
        _add2CartItemID.text=data.realItemId;
        _pageUrl.text=data.taokePageUrl;
        _requestUrl.text=data.pageUrl;
    } else {
        _itemID.text=data.openItemId1;
        _MiniItemID.text=data.openItemId1;
        _add2CartItemID.text=data.openItemId1;
        _pageUrl.text=data.taokePageUrl;
        _requestUrl.text=data.pageUrl;
        
    }
    _shopID.text=data.shopId;
    _myOrderStatus.text=[NSString stringWithFormat:@"%li",(long)sender.selectedSegmentIndex];
    _tradeTestData = data;

}


@end
