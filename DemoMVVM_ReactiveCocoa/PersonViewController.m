//
//  PersonViewController.m
//  DemoMVVM_ReactiveCocoa
//
//  Created by Никита Солдатов on 07.07.16.
//  Copyright © 2016 Никита Солдатов. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonViewModel.h"
#import "ReactiveCocoa/ReactiveCocoa.h"

@interface PersonViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *personImageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *surnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) PersonViewModel *viewModel;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self bindViewModel];
    
}

- (void)addViews {
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:@selector(doneButtonDidClicked)];
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
}

-(UITextField *)phoneTextField {
    if (_phoneTextField)  {
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
}

- (void)bindViewModel {
    self.viewModel = [PersonViewModel new];
    RACSignal *validSignal = RACObserve(self.viewModel, validForm);
    RAC(self.navigationItem.rightBarButtonItem, enabled) = validSignal;
    RAC(self.viewModel, nameText) = self.nameTextField.rac_textSignal;
    RAC(self.viewModel, surnameText) = self.surnameTextField.rac_textSignal;
    RAC(self.viewModel, phoneNumberText) = self.phoneTextField.rac_textSignal;
    RAC(self.navigationItem, title) = RACObserve(self.viewModel, fullName);
    RAC(self.callButton, enabled) = RACObserve(self.viewModel, validPhoneNumber);


}


- (IBAction)callButtonDidClicked:(id)sender {
    UIAlertController *callAllertController = [UIAlertController alertControllerWithTitle:@"Call" message:@"Would you like to call the number?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [callAllertController addAction:cancelAction];
    [self presentViewController:callAllertController animated:YES completion:nil];
}

- (void)doneButtonDidClicked {
    [self.viewModel saveModel];
    [self performSegueWithIdentifier:@"unwindToPersonTableViewController" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
