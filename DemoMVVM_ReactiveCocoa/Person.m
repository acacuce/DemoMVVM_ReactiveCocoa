//
//  Person.m
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 08.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithName:(NSString *)name surname:(NSString *)surname andPhoneNumber:(NSNumber *)phoneNumber
{
    self = [super init];
    if (self) {
        _name = name;
        _surname = surname;
        _phoneNumber = phoneNumber;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *surname = [dictionary objectForKey:@"surname"];
    NSNumber *phoneNumber = [dictionary objectForKey:@"phoneNumber"];
    return [self initWithName:name surname:surname andPhoneNumber:phoneNumber];
}
@end
