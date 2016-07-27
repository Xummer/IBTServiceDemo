//
//  IBTServiceCenter.m
//  ServiceCenterDemo
//
//  Created by Xummer on 16/7/27.
//  Copyright © 2016年 Xummer. All rights reserved.
//

#import "IBTServiceCenter.h"
#import "IBTService.h"

@interface IBTServiceCenter ()
{
    NSMutableDictionary *_dicService;
    NSRecursiveLock *_lock;
}
@end

@implementation IBTServiceCenter

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
#if TARGET_OS_IPHONE
    // Subscribe to app events
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    
    [notiCenter addObserver:self
                   selector:@selector(callServiceMemoryWarning)
                       name:UIApplicationDidReceiveMemoryWarningNotification
                     object:nil];
    
    [notiCenter addObserver:self
                   selector:@selector(callTerminate)
                       name:UIApplicationWillTerminateNotification
                     object:nil];
    
    [notiCenter addObserver:self
                   selector:@selector(callEnterBackground)
                       name:UIApplicationDidEnterBackgroundNotification
                     object:nil];
    
    [notiCenter addObserver:self
                   selector:@selector(callEnterForeground)
                       name:UIApplicationWillEnterForegroundNotification
                     object:nil];
#endif // TARGET_OS_IPHONE
    
    _dicService = [NSMutableDictionary dictionary];
    _lock = [[NSRecursiveLock alloc] init];
    
    return self;
}

- (void)dealloc {
    _dicService = nil;
    _lock = nil;
    
#if TARGET_OS_IPHONE
    // Remove to app events
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter removeObserver:self
                          name:UIApplicationWillTerminateNotification
                        object:nil];
    
    [notiCenter removeObserver:self
                          name:UIApplicationDidReceiveMemoryWarningNotification
                        object:nil];
    
    [notiCenter removeObserver:self
                          name:UIApplicationDidEnterBackgroundNotification
                        object:nil];
    
    [notiCenter removeObserver:self
                          name:UIApplicationWillEnterForegroundNotification
                        object:nil];
#endif // TARGET_OS_IPHONE
    
}

#pragma mark - Public Method

+ (nonnull instancetype)defaultCenter {
    static id _sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCenter = [[self alloc] init];;
    });
    
    return _sharedCenter;
}

- (nullable id)getService:(Class __nonnull)clsServiceName {
    
    IBTService <IBTService> * service = nil;
    
    if ([clsServiceName isSubclassOfClass:[IBTService class]]) {
        [_lock lock];
        
        service = _dicService[ clsServiceName ];
        
        if (!service) {
            service = [[clsServiceName alloc] init];
            if ([service respondsToSelector:@selector(onServiceInit)]) {
                [service onServiceInit];
            }
            
            if (service) {
                _dicService[ [clsServiceName copy] ] = service;
            }
        }
        
        [_lock unlock];
    }
    
    return service;
}

- (void)removeService:(Class __nonnull)clsServiceName {
    
    if ([clsServiceName isSubclassOfClass:[IBTService class]]) {
        [_lock lock];
        
        IBTService <IBTService> *service = _dicService[ clsServiceName ];
        
        service.m_bIsServiceRemoved = YES;
        
        [_dicService removeObjectForKey:clsServiceName];
        
        [_lock unlock];
    }
}

- (void)callReloadData {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceReloadData)]) {
            [service onServiceReloadData];
        }
    }
    
    [_lock unlock];
}

- (void)callClearData {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceClearData)]) {
            [service onServiceClearData];
        }
    }
    
    [_lock unlock];
}

- (void)callEnterForeground {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceEnterForeground)]) {
            [service onServiceEnterForeground];
        }
    }
    
    [_lock unlock];
}

- (void)callEnterBackground {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceEnterBackground)]) {
            [service onServiceEnterBackground];
        }
    }
    
    [_lock unlock];
}

- (void)callTerminate {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceTerminate)]) {
            [service onServiceTerminate];
        }
    }
    
    [_lock unlock];
}

- (void)callServiceMemoryWarning {
    [_lock lock];
    
    for (id<IBTService> service in [_dicService allValues]) {
        if ([service respondsToSelector:@selector(onServiceMemoryWarning)]) {
            [service onServiceMemoryWarning];
        }
    }
    
    [_lock unlock];
}

@end
