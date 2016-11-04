//
//  OrderPayTool.m
//  ZMC
//
//  Created by MindminiMac on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "OrderPayTool.h"

/**
 *  支付宝
 */
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderPayModel.h"
/**
 *  微信
 */
#import "WXApi.h"

@implementation OrderPayTool

/**
 *  支付宝支付
 */

+ (void)AlipayMethodWith:(OrderSingleItem *)item backBlock:(void (^)(NSDictionary *))respond{
    
    /*========商户app填写的信息========*/
    NSString *partner = ALI_PARTNER;
    NSString *seller = ALI_SELLTER;
    NSString *privateKey = ALI_PRIVATE_KEY;
    
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少partner或者seller或者私钥。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    OrderPayModel *order = [[OrderPayModel alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = item.orderSn; //订单ID（由商家自行制定）
    order.productName = @"怎么吃账户充值"; //商品标题
    order.productDescription = @"账户充值"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[item.payPrice floatValue]];
    order.notifyURL =  ALI_CALLBACK_URL; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"ZenMeChi";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        

        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            ZMCLog(@"支付结果reslut = %@",resultDic);
            
            NSString *str = resultDic[@"memo"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:resultDic];
            if (resultDic){
                if ([@"9000" isEqualToString:[resultDic objectForKey:@"resultStatus"]]){
                    
                    [SVProgressHUD showSuccessWithStatus:@"充值成功"];
                    
                }
                else{
                    //交易失败
                    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                    [SVProgressHUD showErrorWithStatus:str];
                }
            }
            else{
                //交易失败
                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                [SVProgressHUD showErrorWithStatus:@"充值失败"];
                
            }
            
        }];
    }
    
}


/**
 *  微信支付
 */
+ (NSString *)jumpToBizPay{
    /**
     *  判断是否装了微信
     */
    if (![WXApi isWXAppInstalled]) {
        ZMCLog(@"没有安装微信");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您还没有微信客户端，不能进行微信支付"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return nil;
        
    }else if (![WXApi isWXAppSupportApi]){
        ZMCLog(@"不支持微信支付");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前微信版本,不支持支付功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return nil;
    }
    
    ZMCLog(@"安装了微信, 而且支持微信支付");
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    
//    NSString *urlStr = @"http://192.168.1.158:8080/fanfou-api/wpay/create/request"

    
    /*
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        
        ZMCLog(@"--->>>>%@", response);
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
     */
                
    NSString *IP = [USER_DEFAULT objectForKey:@"IP"];
    NSString *recharge_sn = [USER_DEFAULT objectForKey:@"recharge_sn"];
    NSDictionary *params = @{
                             @"spbill_create_ip" : IP,
                             @"expired" : @"300",
                             @"trade_type": @"APP",
                             @"order_sn" : recharge_sn
                             };
    
    [HYBNetworking postWithUrl:@"http://115.159.227.219:8088/fanfou-api/wpay/create/request" refreshCache:YES params:params success:^(id response) {
//        NSMutableDictionary *resp = response[@"result"];
        
        
        
        if ([response[@"err_msg"] isEqualToString:@"OK"]) {
        
            NSString *timeStr = response[@"result"][@"time_stamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = response[@"result"][@"partner_id"];
            req.prepayId            = response[@"result"][@"prepay_id"];
            req.nonceStr            = response[@"result"][@"nonce_str"];
            req.timeStamp           = timeStr.intValue;
            req.package             = @"Sign=WXPay";
            req.sign                = response[@"result"][@"pay_sign"];

            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",response[@"result"][@"app_id"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
          
        }else{
            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
            [SVProgressHUD showErrorWithStatus:@"支付失败，请重新尝试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
    } fail:^(NSError *error) {
        ZMCLog(@"微信支付接口错误--->>%@", error);
    }];
    return @"";
}


@end


