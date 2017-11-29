//
//  SaoMaViewController.h
//  NNQRCodeDemo
//
//  Created by 石那那 on 16/1/6.
//  Copyright © 2016年 shinana. All rights reserved.
//

#define KscreenWidth [UIScreen mainScreen].bounds.size.width
#define KscreenHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SaoMaViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL isReading;
    UIView *viewPreview;
    UILabel *statusLab;
    UIButton *cancelButton;
}

- (BOOL)startReading;
- (void)stopReading;

@property(nonatomic,strong)UIImageView *scanImg;
@property(nonatomic,strong)UIView *boxView;
@property(nonatomic,strong)AVCaptureSession *captureSession;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end
