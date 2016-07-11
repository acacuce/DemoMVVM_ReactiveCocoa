//
//  Person.h
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 08.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface Person : NSObject <PersonProtocol>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *surname;
@property (nonatomic, strong) NSNumber *phoneNumber;

- (instancetype)initWithName:(NSString *)name surname:(NSString *)surname andPhoneNumber:(NSNumber *)phoneNumber;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
