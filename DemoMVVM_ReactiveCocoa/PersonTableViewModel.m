//
//  PersonTableViewModel.m
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 08.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import "PersonTableViewModel.h"
#import "PersonStore.h"
#import "Person.h"
#import "UIKit/UITableView.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
@interface PersonTableViewModel()
@property (nonatomic, strong) NSArray *people;
@property (nonatomic, strong) id<PersonStoreProtocol> store;
@end
@implementation PersonTableViewModel


- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [PersonStore new];
        }
    return self;
}

-(NSArray *)people {
    [self.store fetchPeopleWithCompletion:^(NSArray *arr, NSError *err) {
            _people = arr;
    }];
    return _people;
}

- (NSUInteger)numberOfPeopleInSection:(NSInteger)section {
    return self.people.count;
}

- (NSString *)fulNameAtIndexPath:(NSIndexPath *)indexPath {
    id<PersonProtocol> person = self.people[indexPath.row];
    return [NSString stringWithFormat:@"%@ %@", person.name, person.surname];
}

- (NSString *)phoneNumberAtIndexPath:(NSIndexPath *)indexPath {
    id<PersonProtocol> person = self.people[indexPath.row];
    if ([person.phoneNumber isEqualToNumber:@(0)]) {
        return @"";
    }else {
        return  [person.phoneNumber stringValue];
    }
}

@end
