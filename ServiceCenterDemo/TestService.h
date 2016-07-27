//
//  TestService.h
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import "IBTService.h"

@interface TestService : IBTService <IBTService>

- (void)doWhatUWant;

@end
