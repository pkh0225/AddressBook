//
//  AddressBookCell.h
//  S.COM
//
//  Created by pkh on 2016. 6. 27..
//  Copyright © 2016년 Hojun Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressData.h"

@interface AddressBookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneNumberLabel;
- (void)compose:(AddressUIData*)data searchWord:(NSString*)searchWord;
@end
