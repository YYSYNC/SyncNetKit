//
//  SyncNetKitManager.h
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NetworkExtension/NetworkExtension.h>
#import "SyncModel.h"
#import "SyncConfigModel.h"

@interface SyncNetKitManager : NSObject
@property (strong, nonatomic) NEVPNManager *vpnManager;
@property (strong, nonatomic) SyncConfigModel *configModel;
+(id)sharedManager;
-(void)initVpnManger:(SyncConfigModel *)configModel;
-(void)statrtConnect:(SyncModel *)model;
- (void)disconnect;
-(NEVPNStatus)getConnectionStatus;
@end
