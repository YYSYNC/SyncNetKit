//
//  SyncNetKeitKeyChain.h
//  SyncNetKit
//
//  Created by yanyan on 2018/8/29.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncNetKeitKeyChain : NSObject
+(id)sharedManager;
- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;
- (NSData *)searchKeychainCopyMatching:(NSString *)identifier;
- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier;
@end
