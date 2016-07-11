//
//  PersonTableViewModel.h
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 08.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonTableViewModel : NSObject


- (NSUInteger)numberOfPeopleInSection:(NSInteger)section;
- (NSString *)fulNameAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)phoneNumberAtIndexPath:(NSIndexPath *)indexPath;

@end
