//
//  TestService.m
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import "TestService.h"

@implementation TestService

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Custom init
    
    return self;
}

#pragma mark - AMService

- (void)onServiceInit {
    // Add sth. like delegate/observer
}

- (void)onServiceReloadData {
    // Remove sth. like delegate/observer
}

#pragma mark - Public Method

- (void)doWhatUWant {
    NSLog(@"2333");
}

@end
