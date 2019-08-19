//
//  AliTradeWantServiceViewController.m
//  AlibcTradeSDK
//
//  Created by 林峰 on 16/12/21.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AliTradeWantServiceViewController.h"
#import <AlibcTradeContainer/AlibcTradeContainer.h>
#import <AlibcAddCartComponent/AlibcAddCartService.h>
#import <AlibcCouponComponent/AlibcCouponService.h>


//#import <AlibcTradeContainerSDK.h>
//#import <AlibcAddCartService.h>
//#import <AlibcCouponService.h>

#import "MyAlertView.h"


@interface AliTradeWantServiceViewController()
@property (weak, nonatomic) IBOutlet UITextField *addCartItemIDText;



@property (weak, nonatomic) IBOutlet UITextField *supplierIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *uuidTextField;
@property (weak, nonatomic) IBOutlet UITextField *couponInstanceSourceTextField;
@property (weak, nonatomic) IBOutlet UITextField *asacTextField;
@property (weak, nonatomic) IBOutlet UITextField *puidInTrackParamsTextField;





@end
@implementation AliTradeWantServiceViewController
- (IBAction)dIrectAddCart:(id)sender {
   
    NSError *error = nil;
    id<AlibcAddCartService> packet = (id <AlibcAddCartService>) [[AlibcTradeContainerSDK sharedInstance].getPacketService
                                                                 getPacketByType:AlibcTradeContainerDataTypeAddCart
                                                                 error:&error];
    if (error) {
//        TLOG_DEBUG_F(@"find error: %@", error);
        NSLog(@"find error: %@", error);
    }
    
    [packet addCartWithItemID:self.addCartItemIDText.text taokeParams:nil trackParams:@{@"test":@"test"} successBlock:^(id dataObj) {
//        TLOG_DEBUG(@"加购组件成功");
        NSLog(@"加购组件成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MyAlertView alertViewWithTitle:@"加购成功" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        });
        
    } failedBlock:^(AlibcNetError *error, id dataObj) {
//        TLOG_DEBUG(@"加购组件失败");
        NSLog(@"加购组件失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MyAlertView alertViewWithTitle:@"加购失败" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
             });
    }];

}



- (IBAction)couponGetButtonClicked:(id)sender {
    
    
    //   [[AlibcTradeContainerSDK sharedInstance] asyncInitWithSuccess:^{
    NSError *error = nil;
    id<AlibcCouponService> service = [AlibcCouponService defaultService:&error];
    if (error) {
//        TLOG_DEBUG_F(@"find error: %@", error);
        NSLog(@"find error: %@", error);

    }
    NSMutableDictionary *trackParams = [NSMutableDictionary dictionary];
    trackParams[@"testRaw"] = @"raw";
    trackParams[@"puid"] = self.puidInTrackParamsTextField.text;
    /*
     [service getCouponWithSupplierID:self.supplierIDTextField.text
     uuid:self.uuidTextField.text
     couponInstanceSource:self.couponInstanceSourceTextField.text
     asac:self.asacTextField.text
     taokeParams:nil
     trackParams:trackParams
     successBlock:^(id dataObj) {
     TLOG_ALERT_F(@"succ: %@", dataObj);
     } failedBlock:^(ALiNetError *error, id dataObj) {
     TLOG_ALERT_F(@"fail: %@ => %@", error.code, error.msg);
     }];
     */
    NSDictionary *extParams = @{
                                @"testK" : @"test",
                                ///*
                                @"asac" : @"testAsac",
                                //*/
                                //*
                                @"extInfo" : @{
                                        @"k" : @"v",
                                        //@"ybhpss" : @"testYbhpss",
                                        }
                                //*/
                                };
    [service getCouponWithSupplierID:self.supplierIDTextField.text
                                uuid:self.uuidTextField.text
                couponInstanceSource:self.couponInstanceSourceTextField.text
                                asac:self.asacTextField.text
                         trackParams:trackParams
                           extParams:extParams
                        successBlock:^(id dataObj) {
//                            TLOG_ALERT_F(@"succ: %@", dataObj);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[MyAlertView alertViewWithTitle:@"领取优惠券成功" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            });

                            
                        } failedBlock:^(AlibcNetError *error, id dataObj) {
//                            TLOG_ALERT_F(@"fail: %@ => %@", error.code, error.msg);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[MyAlertView alertViewWithTitle:@"领取优惠券失败" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            });

                        }];
    
    
    //  } failure:^(NSError *error) {
    
    //  }];
    
    
    
}

- (IBAction)couponSellerQueryButtonClicked:(id)sender {
    NSError *error = nil;
    id<AlibcCouponService> service =  [AlibcCouponService defaultService:&error];
    if (error) {
//        TLOG_DEBUG_F(@"find error: %@", error);
        NSLog(@"find error: %@", error);

    }
    NSMutableDictionary *trackParams = [NSMutableDictionary dictionary];
    trackParams[@"testRaw"] = @"raw";
    trackParams[@"puid"] = self.puidInTrackParamsTextField.text;
    [service querySellerCouponList:^(id dataObj) {
//        TLOG_ALERT_F(@"succ: %@", dataObj);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MyAlertView alertViewWithTitle:@"优惠券查询成功：" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        });


    } failedBlock:^(AlibcNetError *error, id dataObj) {
//        TLOG_ALERT_F(@"fail: %@ => %@", error.code, error.msg);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MyAlertView alertViewWithTitle:@"优惠券查询失败：" message:nil oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        });

    }];
}

- (IBAction)TextField_DidEndOnExit:(id)sender {
    // 隐藏键盘.
    [sender resignFirstResponder];
}

@end
