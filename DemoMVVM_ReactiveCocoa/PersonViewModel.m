//
//  PersonViewModel.m
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 07.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import "PersonViewModel.h"
#import "Person.h"
#import "PersonStore.h"
#import "Protocols.h"
@interface PersonViewModel()
@property (nonatomic, readonly) id<PersonStoreProtocol> store;
@property (nonatomic, strong) id<PersonProtocol> person;
@end

@implementation PersonViewModel
@synthesize store = _store;
@synthesize person = _person;


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    RAC(self, validForm) = [RACSignal
                            combineLatest:@[RACObserve(self, nameText), RACObserve(self, surnameText)]
                            reduce:^id(NSString *currentName, NSString *currentSurname){
                                return @((currentName.length > 0) && (currentSurname.length > 0));
                                }];
    RAC(self, fullName) = [RACSignal
                           combineLatest:@[RACObserve(self, nameText), RACObserve(self, surnameText)]
                            reduce:^id(NSString *currentName, NSString *currentSurname){
                                NSString *fullName = [NSString new];
                                if (currentName.length > 0) {
                                    currentName = [currentName stringByAppendingString:@" "];
                                    fullName = [fullName stringByAppendingString:currentName];
                                }
                                if (currentSurname.length > 0) {
                                    fullName = [fullName stringByAppendingString:currentSurname];
                                }
                                return !fullName? @"": fullName;
                            }];
    RAC(self, validPhoneNumber) = [RACObserve(self, phoneNumberText)
                                   map:^id(NSString *value) {
                                       return @(value.length == 11);
                                   }];
    
    
}

- (id <PersonStoreProtocol>)store {
    if (!_store) {
        _store = [PersonStore new];
    }
    return _store;
}

- (id <PersonProtocol>)person {
    return [[Person alloc] initWithName:_nameText surname:_surnameText andPhoneNumber:@([_phoneNumberText integerValue])];
}

- (void)saveModel {
    [self.store writePeople:@[self.person]];
}


@end
