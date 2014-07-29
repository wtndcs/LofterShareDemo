//
//  LofterApiObject.h
//  LofterApi
//
//  Version 1.0
//  Created by Netease on 14-7-22.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

enum LofterRespCode {
    kLFTRespSuccess       = 0,     /** 成功 */
    kLFTRespErrCommon     = -1,    /** 普通错误类型 */
    kLFTRespErrUserCancel = -2,    /** 用户点击取消并返回 */
    kLFTRespErrSentFail   = -3,    /** 发送失败 */
    kLFTRespErrAuthDeny   = -4,    /** 授权失败 */
    kLFTRespErrUnsupport  = -5,    /** 不支持 */
};

/**
 * 该类为Lofter所有请求类的基类
 */
@interface LofterBaseReq : NSObject

/** 请求类型 */
@property (nonatomic, assign) int type;

@end

/**
 * 该类为Lofter所有响应类的基类
 */
@interface LofterBaseResp : NSObject

/** 错误码 */
@property (nonatomic, assign) int errCode;

/** 错误提示字符串 */
@property (nonatomic, strong) NSString *errStr;

/** 响应类型 */
@property (nonatomic, assign) int type;

@end

@class LofterMediaMessage;

/**
 * 第三方程序发送消息至Lofter的消息结构体
 *
 * 第三方App向Lofter客户端发送的讯息对象，
 * 可能的类型：多媒体
 */
@interface SendMessageToLofterReq : LofterBaseReq

/** 
 * 发送消息的多媒体内容
 * @see LofterMediaMessage
 */
@property (nonatomic, strong) LofterMediaMessage *message;

@end

/**
 * Lofter客户端向第三方App返回的处理结果。
 */
@interface SendMessageToLofterResp : LofterBaseResp

@end

/**
 * 多媒体消息结构体
 */
@interface LofterMediaMessage : NSObject

/**
 * 构造消息
 */
+(LofterMediaMessage *) message;

/**
 * 消息内容
 */
@property (nonatomic, strong) NSString *content;

/**
 * 多媒体数据对象，目前包括LofterPostMediaObject对象
 */
@property (nonatomic, strong) id mediaObject;

@end

/**
 * 文章多媒体对象
 */
@interface LofterPostMediaObject : NSObject

/**
 * 返回一个LofterPostMediaObject对象
 */
+(instancetype) object;

@property (nonatomic, strong) NSArray *tagNameList;

@end

/**
 * 多媒体消息中包含的图片数据对象
 *
 * @note thumbData和imageData成员不能为空
 */
@interface LofterPostImageObject : LofterPostMediaObject

/** 
 * 缩略图数据
 * @attention 内存大小不能超过50k
 */
@property (nonatomic, strong) NSData   *thumbData;

/** 
 * 设置消息缩略图的方法
 *
 * @param image 缩略图
 * @attention 内存大小不能超过50k
 */
- (void) setThumbImage:(UIImage *)image;

/**
 * 图片真实数据内容
 *
 * @note 大小不能超过10M
 */
@property (nonatomic, strong) NSData *imageData;

@end

