//
//  PersonStore.m
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 10.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//


#import "PersonStore.h"
#import "Person.h"
@interface PersonStore()
@property (nonatomic, strong) NSString *storePath;
@end
@implementation PersonStore

-(instancetype)init {
    self = [super init];
    if (self) {
        self.storePath =  [[NSBundle mainBundle] pathForResource:@"PeopleList" ofType:@".plist"];
    }
    return self;
}

- (void)fetchPeopleWithCompletion:(void(^)(NSArray *arr, NSError *err))completion {
    
    NSData *dataWithContentPlist = [NSData dataWithContentsOfFile:self.storePath];
    if (!dataWithContentPlist) {
        NSLog(@"error reading");
    }else {
        NSPropertyListFormat *format;
        NSError *error = nil;
        id plist = [NSPropertyListSerialization propertyListWithData:dataWithContentPlist options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
        if (!error) {
            NSMutableDictionary *root = [NSMutableDictionary dictionaryWithContentsOfFile:self.storePath];
            NSMutableArray *readArray = [[NSMutableArray alloc] initWithArray:[root objectForKey:@"people"]];
            NSMutableArray *people = [NSMutableArray new];
            for (NSDictionary *dict in readArray) {
                id<PersonProtocol> person = [[Person alloc] initWithDictionary:dict];
                [people addObject:person];
            }
            completion ([people copy], nil);
        }else {
            NSLog(@"error");
            completion (nil, error);
        }
    }
}

- (void)writePeople:(NSArray *)people {
    NSMutableDictionary *root = [NSMutableDictionary dictionaryWithContentsOfFile:self.storePath];
    [root setObject:@YES forKey:@"autosave"];
    [root setObject:@"4F4@@" forKey:@"identifier"];
    NSMutableArray *peopleArr = [[NSMutableArray alloc] initWithArray:[root objectForKey:@"people"]];
    for (id<PersonProtocol> currentPerson in people) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:currentPerson.name forKey:@"name"];
        [dict setObject:currentPerson.surname forKey:@"surname"];
        [dict setObject:currentPerson.phoneNumber forKey:@"phoneNumber"];
        [peopleArr addObject:[dict copy]];
    }
    [root setObject:peopleArr forKey:@"people"];
    
    NSError *error = nil;
    NSData *representation = [NSPropertyListSerialization dataWithPropertyList:root format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    if (!error) {
        BOOL ok = [representation writeToFile:self.storePath atomically:YES];
        if (ok) {
//            NSLog(@"%@", root);
            NSLog(@"ok");
            [self fetchPeopleWithCompletion:^(NSArray *arr, NSError *err) {
                NSLog(@"%@", arr);
            }];
            
        }else {
            NSLog(@"error to write");
        }
    }
}



@end
