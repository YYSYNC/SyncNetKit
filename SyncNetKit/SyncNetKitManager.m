//
//  SyncNetKitManager.m
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "SyncNetKitManager.h"
#import "SyncProfileManager.h"
#import "SyncNetKeitKeyChain.h"


@implementation SyncNetKitManager
+(id)sharedManager{
    static SyncNetKitManager *_manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

-(NEVPNStatus)getConnectionStatus{
    if (!_vpnManager){
        _vpnManager=[NEVPNManager sharedManager];
    }
    return self.vpnManager.connection.status;
}


-(void)initVpnManger:(SyncConfigModel *)configModel{
    _configModel = configModel;
    _vpnManager=[NEVPNManager sharedManager];
    [self.vpnManager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

-(void)statrtConnect:(SyncModel *)model{
    [self configProfile:model];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(vpnConfigDidChanged:)
               name:NEVPNConfigurationChangeNotification
             object:nil];
}

- (void)vpnConfigDidChanged:(NSNotification *)notification{
    [self startConnecting];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NEVPNConfigurationChangeNotification
                                                  object:nil];
}

- (void)startConnecting{
    NSError *startError;
    [self.vpnManager.connection startVPNTunnelAndReturnError:&startError];
    if (startError) {
        NSLog(@"Start VPN failed: [%@]", startError.localizedDescription);
    }
}

- (void)disconnect{
    [_vpnManager.connection stopVPNTunnel];
}


-(void)configProfile:(SyncModel *)model{
    [[SyncProfileManager sharedManager] installProfile:model];
    
    // Load config from perference
    [_vpnManager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        
        if (error) {
            NSLog(@"Load config failed [%@]", error.localizedDescription);
            return;
        }
        
        NEVPNProtocolIKEv2 *p = (NEVPNProtocolIKEv2 *)self.vpnManager.protocolConfiguration;
        
        if (p) {
            // Protocol exists.
            // If you don't want to edit it, just return here.
        } else {
            // create a new one.
            p = [[NEVPNProtocolIKEv2 alloc] init];
        }
        
        p.username = model.username;
        p.serverAddress = model.server;
        p.passwordReference = [[SyncNetKeitKeyChain sharedManager] searchKeychainCopyMatching:@"VPN_PASSWORD"];
        
        p.localIdentifier = model.localIdnetifier;
        p.remoteIdentifier = model.remoteIdentifier;
        
        p.useExtendedAuthentication = YES;
        p.disconnectOnSleep = NO;
        
        self.vpnManager.protocolConfiguration = p;
        self.vpnManager.localizedDescription = self.configModel.localizedDescription;
        self.vpnManager.enabled = YES;
        
        [self.vpnManager saveToPreferencesWithCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Save config failed [%@]", error.localizedDescription);
            }
        }];
    }];
}

@end
