//
//  SaoMaViewController.m
//  NNQRCodeDemo
//
//  Created by 石那那 on 16/1/6.
//  Copyright © 2016年 shinana. All rights reserved.
//

#import "SaoMaViewController.h"
#import "ViewController.h"
@interface SaoMaViewController ()

@end

@implementation SaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captureSession = nil;
    isReading = NO;    
    [self addHeaderView];
    
    if (!isReading)
    {
        if ([self startReading])
        {
            viewPreview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
            [self.view addSubview:viewPreview];

            [self addLayer];
        }
    }
    isReading = !isReading;
}
- (void)addHeaderView
{
    UIImage *headBg = [UIImage imageNamed:@"daohanglan_bg_Default_738h@3x"];
    UIImageView *headBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, 44)];
    headBgImage.image = headBg;
    [self.view addSubview:headBgImage];
    UIImage *backButtonImg = [UIImage imageNamed:@"daohanglan_back_btn_Default_738h@3x"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20+(44-backButtonImg.size.height*SCREEN_RATE_Y_6P)/2, backButtonImg.size.width*SCREEN_RATE_X_6P, backButtonImg.size.height*SCREEN_RATE_Y_6P);
    [backButton setBackgroundImage:backButtonImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(backButtonImg.size.width*SCREEN_RATE_X_6P, 20+(44-backButtonImg.size.height*SCREEN_RATE_Y_6P)/2, 80*SCREEN_RATE_X_6P, backButtonImg.size.height*SCREEN_RATE_Y_6P)];
    titleLab.text = @"返回";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLab];

}
- (BOOL)startReading
{
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input)
    {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    [_captureSession addOutput:captureMetadataOutput];

    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    captureMetadataOutput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.5f, 0.5f);

    [_captureSession startRunning];
    return YES;

}
- (void)addLayer
{
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:viewPreview.layer.bounds];
    [viewPreview.layer addSublayer:_videoPreviewLayer];

    CGFloat viewWidth = viewPreview.bounds.size.width;
    CGFloat viewHeight = viewPreview.bounds.size.height;
    
    CGFloat boxWidth = viewWidth - viewWidth * 0.4f;
    CGFloat boxHeight = boxWidth;
    
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(viewWidth * 0.2f, viewHeight * 0.25f, boxWidth, boxHeight)];
    _boxView.layer.borderColor = [UIColor whiteColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [viewPreview addSubview:_boxView];
    UIImageView *boxImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth * 0.2f, viewHeight *0.25f, 32, 32)];
    boxImg1.image = [UIImage imageNamed:@"ScanQR1@2x"];
    [viewPreview addSubview:boxImg1];
    UIImageView *boxImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth * 0.2f+boxWidth-32, viewHeight *0.25f, 32, 32)];
    boxImg2.image = [UIImage imageNamed:@"ScanQR2@2x"];
    [viewPreview addSubview:boxImg2];
    UIImageView *boxImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth * 0.2f, viewHeight*0.25f+boxHeight-32, 32, 32)];
    boxImg3.image = [UIImage imageNamed:@"ScanQR3@2x"];
    [viewPreview addSubview:boxImg3];
    UIImageView *boxImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth * 0.2f+boxWidth-32, viewHeight*0.25f+boxHeight-32, 32, 32)];
    boxImg4.image = [UIImage imageNamed:@"ScanQR4@2x"];
    [viewPreview addSubview:boxImg4];
    
    _scanImg = [[UIImageView alloc]init];
    _scanImg.frame = CGRectMake(-50, 0, boxWidth+100, 15);
    _scanImg.image = [UIImage imageNamed:@"QRCodeScanLine@2x"];
    [_boxView addSubview:_scanImg];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    
    statusLab = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-300)/2, viewHeight * 0.25f+boxWidth+10, 300, 40)];
    statusLab.numberOfLines = 0;
    [statusLab setText:@"正在扫描......"];
    statusLab.textColor = [UIColor greenColor];
    statusLab.textAlignment = NSTextAlignmentCenter;
    [viewPreview addSubview:statusLab];


}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        [statusLab performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
        isReading = NO;
    }
}
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanImg.frame;
    if (_boxView.frame.size.height < _scanImg.frame.origin.y+15)
    {
        frame.origin.y = 0;
        _scanImg.frame = frame;
    }
    else
    {
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanImg.frame = frame;
        }];
    }
}
- (void)cancelClick
{
    ViewController *mainController = [[ViewController alloc]init];
    mainController.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].delegate.window setRootViewController:mainController];
}
-(void)stopReading
{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanImg removeFromSuperview];
    [_videoPreviewLayer removeFromSuperlayer];
    
    ViewController *mainController = [[ViewController alloc]init];
    mainController.string = statusLab.text;
    mainController.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].delegate.window setRootViewController:mainController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
