//
//  CreatQRCodeViewController.m
//  NNQRCodeDemo
//
//  Created by 石那那 on 16/1/6.
//  Copyright © 2016年 shinana. All rights reserved.
//

#import "CreatQRCodeViewController.h"
#import "QRCodeGenerator.h"
#import "ViewController.h"
@interface CreatQRCodeViewController ()<UITextFieldDelegate>

@end

@implementation CreatQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, KScreenHeight-20)];
    bgImage.image = [UIImage imageNamed:@"bg_Default_738h@3x"];
    [view addSubview:bgImage];
    
    UIImage *headBg = [UIImage imageNamed:@"daohanglan_bg_Default_738h@3x"];
    UIImageView *headBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, 44)];
    headBgImage.image = headBg;
    [view addSubview:headBgImage];
    UIImage *backButtonImg = [UIImage imageNamed:@"daohanglan_back_btn_Default_738h@3x"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20+(44-backButtonImg.size.height*SCREEN_RATE_Y_6P)/2, backButtonImg.size.width*SCREEN_RATE_X_6P, backButtonImg.size.height*SCREEN_RATE_Y_6P);
    [backButton setBackgroundImage:backButtonImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(backButtonImg.size.width*SCREEN_RATE_X_6P, 20+(44-backButtonImg.size.height*SCREEN_RATE_Y_6P)/2, 80*SCREEN_RATE_X_6P, backButtonImg.size.height*SCREEN_RATE_Y_6P)];
    titleLab.text = @"返回";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    [view addSubview:titleLab];

    UIImageView *headerImg = [[UIImageView alloc]init];
    headerImg.frame = CGRectMake(20*SCREEN_RATE_X_6P, 84*SCREEN_RATE_Y_6P, 80*SCREEN_RATE_X_6P, 80*SCREEN_RATE_Y_6P);
    headerImg.layer.cornerRadius = 40;
    headerImg.clipsToBounds = YES;
    headerImg.image = [UIImage imageNamed:@"zhujiemian_pindaotouxian_moren_Default@2x"];
    [view addSubview:headerImg];
    
    UILabel *numLab = [[UILabel alloc]init];
    numLab.frame = CGRectMake(100*SCREEN_RATE_X_6P, 84*SCREEN_RATE_Y_6P, 200*SCREEN_RATE_X_6P, 80*SCREEN_RATE_Y_6P);
    numLab.font = [UIFont systemFontOfSize:17*SCREEN_RATE_Y_6P];
    numLab.text = self.text;
    numLab.textColor = [UIColor whiteColor];
    [view addSubview:numLab];

    UIImage *img = [QRCodeGenerator qrImageForString:self.text imageSize:300];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-300*SCREEN_RATE_X_6P)/2, 200*SCREEN_RATE_Y_6P, 300*SCREEN_RATE_X_6P, 300*SCREEN_RATE_Y_6P)];
    imgView.image = img;
    imgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imgView];

}
- (void)backButtonClick
{
    ViewController *mainController = [[ViewController alloc]init];
    mainController.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].delegate.window setRootViewController:mainController];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *textF = [self.view viewWithTag:100];
    [textF resignFirstResponder];
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
