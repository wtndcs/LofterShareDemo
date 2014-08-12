//
//  ShareViewController.h
//  LofterShareDemo
//
//  Created by wtndcs on 14-7-29.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, weak) IBOutlet UITextField *tag1View;
@property (nonatomic, weak) IBOutlet UITextField *tag2View;

- (IBAction)chooseImg:(id)sender;
- (IBAction)shareToLofter:(id)sender;

@end
