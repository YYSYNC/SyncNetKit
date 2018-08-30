//
//  SyncProfileManager.m
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "SyncProfileManager.h"
#import <NetworkExtension/NetworkExtension.h>
#import "SyncNetKeitKeyChain.h"

@implementation SyncProfileManager

+(id)sharedManager{
    static SyncProfileManager *_manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)installProfile:(SyncModel *)model {
    // Save password & psk
    [[SyncNetKeitKeyChain sharedManager] createKeychainValue:model.password forIdentifier:@"VPN_PASSWORD"];
    if (model.presharedKey.length>0){
        [[SyncNetKeitKeyChain sharedManager] createKeychainValue:model.presharedKey forIdentifier:@"VPN_PSK"];
    }

}

@end
