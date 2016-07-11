//
//  PersonViewModel.h
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 07.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "Person.h"

@interface PersonViewModel : NSObject
@property (strong, nonatomic) NSString *nameText;
@property (strong, nonatomic) NSString *surnameText;
@property (strong, nonatomic) NSString *phoneNumberText;
@property (strong, nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly, getter=isValidForm) BOOL validForm;
@property (nonatomic, readonly, getter=isValidPhoneNumber) BOOL validPhoneNumber;

- (void)saveModel;

@end
