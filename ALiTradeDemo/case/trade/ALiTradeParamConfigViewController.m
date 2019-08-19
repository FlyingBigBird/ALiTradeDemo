//
//  ALiTradeParamConfigViewController.m
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 15/11/3.
//  Copyright © 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeParamConfigViewController.h"
#import "ALiTradeParamConfigTableCell.h"
#import "ALiTradeSDKShareParam.h"

//#import "ALiTradeShowPageViewController.h"


@interface ALiTradeParamConfigViewController()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>


@property(strong,nonatomic) NSMutableDictionary *tmpParams;

@property(strong,nonatomic) NSMutableArray *keys;
@property(strong,nonatomic) NSMutableArray *values;

@end

@implementation ALiTradeParamConfigViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏
      self.navigationItem.rightBarButtonItem =  self.editButtonItem;
//    self.navigationItem.title = @"参数插入和删除";
    self.keys=[[NSMutableArray alloc] initWithCapacity:5];
    self.values=[[NSMutableArray alloc] initWithCapacity:5];
    self.tmpParams=[ALiTradeSDKShareParam sharedInstance].externParams;
    [self.keys addObjectsFromArray:[ALiTradeSDKShareParam sharedInstance].externParams.allKeys];
    [self.values  addObjectsFromArray:[ALiTradeSDKShareParam sharedInstance].externParams.allValues];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{

    [super setEditing:editing animated:YES];
    [self.tableView setEditing:editing animated:YES];
    if (self.editing) {
        self.editButtonItem.title=@"完成";
    } else {
        self.editButtonItem.title=@"修改";
    }
}
//关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ALiTradeSDKShareParam sharedInstance].externParams removeAllObjects];
    for (NSInteger index=0; index<[self.keys count]; index++) {
        if ([self.keys[index] length]>0) {
            [ALiTradeSDKShareParam sharedInstance].externParams[self.keys[index]] = self.values[index];
        }
    }
    if ([self.tmpParams isEqual:[ALiTradeSDKShareParam sharedInstance].customParams]) {
        [ALiTradeSDKShareParam sharedInstance].customParams=[ALiTradeSDKShareParam sharedInstance].externParams;
    } else {
        [ALiTradeSDKShareParam sharedInstance].taoKeParams=[ALiTradeSDKShareParam sharedInstance].externParams;

    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.keys count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ALiTradeParamConfigTableCell";
    ALiTradeParamConfigTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.accessibilityIdentifier=self.keys[indexPath.row] ;
    cell.keyText.tag = cell.valueText.tag = indexPath.row;
    cell.keyText.text=self.keys[indexPath.row] ;
    cell.valueText.text=self.values[indexPath.row];
    [cell.keyText addTarget:self action:@selector(keyEditEnd:) forControlEvents:UIControlEventEditingChanged];
    [cell.valueText addTarget:self action:@selector(valueEditEnd:) forControlEvents:UIControlEventEditingChanged];
    [cell.keyText addTarget:self action:@selector(TextField_DidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [cell.valueText addTarget:self action:@selector(TextField_DidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.keys removeObjectAtIndex:indexPath.row];
        [self.values removeObjectAtIndex:indexPath.row];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self.keys insertObject:@"" atIndex:indexPath.row + 1];
        [self.values insertObject:@"" atIndex:indexPath.row + 1];
    }
    [self.tableView reloadData];
}

#pragma mark --UITableViewDelegate 协议方法

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row =0;
    row=[indexPath row];
    
    if ([self.tmpParams isEqual:[ALiTradeSDKShareParam sharedInstance].customParams]) {
                 if ([[self keys] count]<=1) {
                    return UITableViewCellEditingStyleDelete;
                 }
                 else {
                         if (row ==[self.keys count]-1) {
                                return UITableViewCellEditingStyleInsert;
                        } else {
    
                         return UITableViewCellEditingStyleDelete;
                       }
        }
 
    } else {
     return UITableViewCellEditingStyleDelete;
      
    }

}

- (void)keyEditEnd:(UITextField *)sender {
    [self.keys replaceObjectAtIndex:sender.tag withObject:sender.text];
}

-(void)valueEditEnd:(UITextField *)sender{
    [self.values replaceObjectAtIndex:sender.tag withObject:sender.text];
}

- (void)TextField_DidEndOnExit:(UITextField *)sender {
    // 隐藏键盘.
    [sender resignFirstResponder];
}

@end
