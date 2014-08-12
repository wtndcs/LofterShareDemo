//
//  ShareImagePickerController.m
//  LofterShareDemo
//
//  Created by wtndcs on 14-8-12.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import "ShareImagePickerController.h"

@interface ShareImagePickerController ()

@end

@implementation ShareImagePickerController

+ (void)presentImagePickerFromController:(UIViewController *)controller;
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ShareImagePickerController* picker = [[ShareImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        [controller presentModalViewController:picker animated:YES];
    }
}

@end
