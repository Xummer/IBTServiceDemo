//
//  IBTServiceCenter.h
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IBTServiceWithName(SERVICE_NAME) \
        [[IBTServiceCenter defaultCenter] getService:[SERVICE_NAME class]]

@interface IBTServiceCenter : NSObject

+ (nonnull instancetype)defaultCenter;
- (nullable id)getService:(Class __nonnull)clsServiceName;
- (void)removeService:(Class __nonnull)clsServiceName;

- (void)callReloadData;
- (void)callClearData;

- (void)callEnterForeground;
- (void)callEnterBackground;
- (void)callTerminate;
- (void)callServiceMemoryWarning;

@end
