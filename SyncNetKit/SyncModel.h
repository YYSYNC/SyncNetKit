//
//  SyncModel.h
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncModel : NSObject

@property(nonatomic,copy)NSString *server;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *remoteIdentifier;
@property(nonatomic,copy)NSString *localIdnetifier;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *presharedKey;
@end
