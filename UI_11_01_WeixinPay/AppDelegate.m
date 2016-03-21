//
//  AppDelegate.m
//  UI_11_01_WeixinPay
//
//  Created by nil on 16/3/21.
//  Copyright © 2016年 CenLei. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     *  微信测试 APPID
        1.导入微信支付，SDK,注册微信支付
        2.设置微信 APPID 为 URL Schemes
        3.发起支付，调取微信支付
        4.处理支付结果
     */
    
#warning 先在 URL Types的位置和下一行代码中“填写你的微信APPID”
    [WXApi registerApp:@"填写你的微信APPID" withDescription:@"weixinDemo"];
    
    
    return YES;
}


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        //返回支付结果,实际支付结果需要取微信服务端查询
        NSString *strMsg = @"支付结果";
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付成功";
                NSLog(@"支付成功-PaySuccess,resp.errCode = %d",resp.errCode);
                break;
                
            default:
                strMsg = @"支付失败";
                NSLog(@"支付失败-PaySuccess,resp.errCode = %d,resp.errStr = %@",resp. errCode,resp.errStr);
                break;
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%d",resp.errCode ]message:resp.errStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:sure];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}


#pragma mark - 跳转到微信应用（第三方）
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
