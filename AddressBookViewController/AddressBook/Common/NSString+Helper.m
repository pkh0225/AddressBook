//
//  NSString+Helper.m
//  ChatOnClient
//
//  Created by pkh on 2014. 5. 9..
//
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSString *)trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isValid
{
    if (((NSNull *)self == [NSNull null]) || (self == nil) || ([self length] == 0) || ([[self trim] length] == 0) || [self isEqualToString:@"(null)"] || [self isEqualToString:@"null"])
    {
        return NO;
    }
    
    return YES;
}


- (BOOL)isKorString
{
    for (int i=0;i<[self length];i++) {
        NSInteger code = [self characterAtIndex:i];
        if (code >= 44032 && code <= 55203) {
            return YES;
        }
    }
    return NO;
}

@end


@implementation NSNull (Helper)

- (BOOL)isValid
{
    return NO;
}

- (NSInteger)count
{
    return 0;
}
- (BOOL)isEqualToString:(NSString*)str
{
    return NO;
}

@end
