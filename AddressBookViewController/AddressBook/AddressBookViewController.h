//  S.COM
//
//  Created by pkh on 2016. 6. 27..
//  Copyright © 2016년 Hojun Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressData.h"

typedef void(^AddressBookCallback)(AddressUIData* addressBookData);

@interface AddressBookViewController : UIViewController

@property (copy, nonatomic) AddressBookCallback callback;
@property (weak, nonatomic) IBOutlet UIView *statusBar;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *searchIconView;
@property (weak, nonatomic) IBOutlet UIView *noResultView;
@property (weak, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) NSString *searchWord;
@property (weak, nonatomic) IBOutlet UIView *topTitleView;

- (void)setAddressBookCallback:(AddressBookCallback)callback;

@end
