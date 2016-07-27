//
//  ViewController.m
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import "ViewController.h"
#import "IBTServiceCenter.h"
#import "TestService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestService *tMgr = IBTServiceWithName(TestService);
    [tMgr doWhatUWant];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
