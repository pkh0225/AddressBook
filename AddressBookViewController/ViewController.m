//
//  ViewController.m
//  AddressBookViewController
//
//  Created by pkh on 2018. 8. 20..
//  Copyright © 2018년 pkh. All rights reserved.
//

#import "ViewController.h"
#import "AddressBookViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddressBook:(UIButton *)sender {
    __block AddressBookViewController *addressBook = [[AddressBookViewController alloc] initWithNibName:@"AddressBookViewController" bundle:nil];
    addressBook.callback = ^(AddressUIData *addressBookData) {
        if (addressBookData != nil) {
            NSString *string = [NSString stringWithFormat:@"Name: %@\nNumber: %@", addressBookData.m_name, addressBookData.m_numberUI];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"알림" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:YES completion:nil];
            });
            
            
            
            
        }
        addressBook = nil;
    };
    
    [self presentViewController:addressBook animated:YES completion:nil];
}

@end
