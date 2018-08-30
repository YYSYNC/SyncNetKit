//
//  SyncProfileManager.h
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncModel.h"

@interface SyncProfileManager : NSObject
+(id)sharedManager;
- (void)installProfile:(SyncModel *)model;
@end
