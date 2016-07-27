//
//  IBTService.h
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBTService <NSObject>

@optional
- (void)onServiceInit;
- (void)onServiceReloadData;
- (void)onServiceEnterBackground;
- (void)onServiceEnterForeground;
- (void)onServiceTerminate;
- (BOOL)onServiceMemoryWarning;
- (void)onServiceClearData;

@end

@interface IBTService : NSObject

@property (assign) BOOL m_bIsServicePersistent;
@property (assign) BOOL m_bIsServiceRemoved;

@end

