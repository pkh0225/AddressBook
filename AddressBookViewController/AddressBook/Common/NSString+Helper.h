//
//  
//  ChatOnClient
//
//  Created by pkh on 2014. 5. 9..
//
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)trim;
- (BOOL)isValid;

- (BOOL)isKorString;
@end


@interface NSNull (Helper)

- (BOOL)isValid;
- (NSInteger)count;
- (BOOL)isEqualToString:(NSString*)str;
@end
