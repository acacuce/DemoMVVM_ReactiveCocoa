//
//  PersonStore.h
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 10.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface PersonStore : NSObject <PersonStoreProtocol>

- (void)writePeople:(NSArray *)people;
- (void)fetchPeopleWithCompletion:(void(^)(NSArray *arr, NSError *err))completion;

@end
