//
//  ALiTradeParamConfigTableCell.h
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 15/11/3.
//  Copyright © 2015年 alibaba. All rights reserved.
//

#ifndef ALiTradeParamConfigTableCell_h
#define ALiTradeParamConfigTableCell_h
#import <UIKit/UIKit.h>

@interface ALiTradeParamConfigTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *key;

@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UITextField *keyText;
@property (weak, nonatomic) IBOutlet UITextField *valueText;

@end

#endif /* ALiTradeParamConfigTableCell_h */
