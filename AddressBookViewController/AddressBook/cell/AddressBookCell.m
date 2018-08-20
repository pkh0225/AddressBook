//
//  AddressBookCell.m
//  S.COM
//
//  Created by pkh on 2016. 6. 27..
//  Copyright © 2016년 Hojun Kim. All rights reserved.
//

#import "AddressBookCell.h"
#import "NSString+Helper.h"

@implementation AddressBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)compose:(AddressUIData*)data searchWord:(NSString*)searchWord {
    self.userNameLabel.text =  data.m_name;
    self.userPhoneNumberLabel.text = data.m_numberUI;
    
    if ([searchWord isValid])
    {
        NSRange colorRange;
        NSMutableAttributedString *attributedtext;
        
        if (data.searchType == AddressSearchTypeNumber) {
            colorRange = [data.m_number rangeOfString:searchWord];
            attributedtext = [[NSMutableAttributedString alloc] initWithString:data.m_number];
            [attributedtext addAttribute: NSForegroundColorAttributeName value:[self colorWithHex:0xff6967] range:colorRange];
            [self.userPhoneNumberLabel setAttributedText: attributedtext];
        }
        else {
            colorRange = [data.m_name rangeOfString:searchWord];
            attributedtext = [[NSMutableAttributedString alloc] initWithString:data.m_name];
            [attributedtext addAttribute: NSForegroundColorAttributeName value:[self colorWithHex:0xff6967] range:colorRange];
            [self.userNameLabel setAttributedText: attributedtext];
        }
    }
    
    if (data.m_selected)
    {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

// takes 0x123456
- (UIColor *)colorWithHex:(UInt32)col
{
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(CGFloat)r / 255.0f green:(CGFloat)g / 255.0f blue:(CGFloat)b / 255.0f alpha:1];
}
@end

