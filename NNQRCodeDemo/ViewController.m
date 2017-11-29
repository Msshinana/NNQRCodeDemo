//
//  ViewController.m
//  NNQRCodeDemo
//
//  Created by 石那那 on 16/1/6.
//  Copyright © 2016年 shinana. All rights reserved.
//

#import "ViewController.h"
#import "CreatQRCodeViewController.h"
#import "SaoMaViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *creatButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    creatButton.frame = CGRectMake((KScreenWidth-100)/2, 80, 120, 40);
//    [creatButton setTitle:@"生成二维码" forState:UIControlStateNormal];
//    [creatButton setBackgroundColor:[UIColor grayColor]];
//    [creatButton addTarget:self action:@selector(creatErWeiMaClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:creatButton];
    

    textF = [[UITextField alloc]initWithFrame:CGRectMake(20, 120, 200, 40)];
    textF.backgroundColor = [UIColor whiteColor];
    textF.layer.borderWidth = 1;
    textF.layer.borderColor = [UIColor grayColor].CGColor;
    textF.layer.cornerRadius = 5;
    textF.clipsToBounds = YES;
    textF.placeholder = @"请输入";
    textF.tag = 100;
    [self.view addSubview:textF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KScreenWidth-120, 120, 100, 40);
    [button setTitle:@"生成二维码" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"chebangshou_qidong_btn_press_Default_738h@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(creatErWeiMaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    saoMaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saoMaButton.frame = CGRectMake(20, 300, 100, 40);
    [saoMaButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [saoMaButton setBackgroundImage:[UIImage imageNamed:@"chebangshou_qidong_btn_press_Default_738h@3x"] forState:UIControlStateNormal];
    [saoMaButton addTarget:self action:@selector(saoMaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saoMaButton];
    
    valueLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-220, 300, 200, 40)];
    valueLab.layer.borderWidth = 1;
    valueLab.layer.borderColor = [UIColor grayColor].CGColor;
    valueLab.layer.cornerRadius = 5;
    valueLab.clipsToBounds = YES;
    valueLab.text = self.string;
    valueLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:valueLab];
}
- (void)creatErWeiMaClick
{
    CreatQRCodeViewController *creatController = [[CreatQRCodeViewController alloc]init];
    creatController.text = textF.text;
    [[UIApplication sharedApplication].delegate.window setRootViewController:creatController];
}
- (void)saoMaClick
{
    SaoMaViewController *saoMaController = [[SaoMaViewController alloc]init];
    [[UIApplication sharedApplication].delegate.window setRootViewController:saoMaController];
    [valueLab removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
