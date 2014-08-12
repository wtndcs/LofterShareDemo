//
//  ShareViewController.m
//  LofterShareDemo
//
//  Created by wtndcs on 14-7-29.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import "ShareViewController.h"
#import "LofterSDK/LofterApi.h"
#import "ShareImagePickerController.h"
#import "UIImage+Resize.h"

@interface ShareViewController ()

@property (nonatomic, strong) UIImage *chooseImage;

@end

@implementation ShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.contentTextView.layer.borderWidth = 1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseImg:(id)sender {
    ShareImagePickerController *picker = [[ShareImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.chooseImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissModalViewControllerAnimated:YES];
}

- (IBAction)shareToLofter:(id)sender
{
    if (![LofterApi isLofterSupportApi]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"请下载最新版本的LOFTER" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (!self.chooseImage) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"请选择图片" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    LofterPostImageObject *shareObj = [LofterPostImageObject object];
    
    // 标签名称，可以不设置
    NSMutableArray *tags = [NSMutableArray array];
    if (self.tag1View.text) {
        [tags addObject:self.tag1View.text];
    }
    if (self.tag2View.text) {
        [tags addObject:self.tag2View.text];
    }
    shareObj.tagNameList = tags;
    
    UIImage *shareImage = self.chooseImage;
    // 将图片转换为NSData，压缩质量参数可以自己控制
    // 或者可以通过NSData *data = [[NSFileManager defaultManager] contentsAtPath:imgFilePath];来得到NSData
    NSData *imgData  = UIImageJPEGRepresentation(shareImage, 0.98);
    [shareObj setImageData:imgData];
    
    // 分享的图片的缩略图，最小边长最好为 110 个像素
    UIImage *shareThumbImage = [shareImage thumbnailImage:110 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationMedium];
    [shareObj setThumbImage:shareThumbImage];
    
    LofterMediaMessage *mediaMsg = [LofterMediaMessage message];
    mediaMsg.mediaObject = shareObj;
    
    // 分享的文字内容，最多10000个字；可以不设置
    mediaMsg.content = self.contentTextView.text;
    
    SendMessageToLofterReq *req = [[SendMessageToLofterReq alloc] init];
    req.message = mediaMsg;
    [LofterApi sendReq:req];
}

@end
