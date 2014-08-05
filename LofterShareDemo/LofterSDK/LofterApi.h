//
//  LofterApi.h
//  LofterApi
//
//  Version 1.0
//  Created by Netease on 14-7-22.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import "LofterApiObject.h"

/**
 * Lofter SDK Delegate
 *
 * 接收来自Lofter客户端的事件讯息，接收后唤起第三方App来处理。
 * SDK会在handleOpenURL中根据讯息回调LofterApiDelegate的方法。
 */
@protocol LofterApiDelegate <NSObject>

/**
 * 收到一个来自Lofter客户端的应答讯息
 *
 * 可能收到的处理结果有SendMessageToLofterResp。
 *
 * @param resp 回应事件讯息的对象
 */
- (void)onReceiveResponse: (LofterBaseResp *)resp;

@end

@interface LofterApi : NSObject

/**
 * 注册第三方App到Lofter客户端。
 *
 * 启动三方App程序时调用。
 *
 * @param appID Lofter中注册的开发者ID
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)registerApp: (NSString *)appID;

/**
 * 检查Lofter客户端是否已安装
 *
 * @return Lofter已安装返回YES，未安装返回NO。
 */
+ (BOOL)isLofterInstalled;

/**
 * 判断当前Lofter客户端的版本是否支持Lofter分享
 *
 * @return 支持返回YES，不支持返回NO。
 */
+(BOOL)isLofterSupportApi;

/**
 * 打开Lofter客户端
 *
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)openLofter;

/**
 * 当isLofterSupportApi返回NO时，调用该方法使用UIAlert提示用户下载最新版本。
 */
+ (void)showDownloadAlertToUser;

/**
 * 第三方App被Lofter客户端通过URL唤起时的调用
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 启动第三方App的URL
 * @param delegate  LofterApiDelegate对象，用来接收Lofter客户端触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenURL: (NSURL *)url delegate: (id<LofterApiDelegate>)delegate;

/**
 * 发送请求讯息到Lofter客户端。
 *
 * 发送讯息后，会唤起Lofter客户端；第三方应用程序等待Lofter返回响应讯息。
 * 可能发送的请求有 SendMessageToLofterReq等。
 * @param req 请求事件讯息的对象。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)sendReq: (LofterBaseReq *)req;

@end
