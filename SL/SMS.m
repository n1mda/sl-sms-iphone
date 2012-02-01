//
//  SMS.m
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SMS.h"

@implementation SMS
@synthesize message,sender,date;

- (NSString *)trimmedSender {
    NSString *trimmedString = [self.sender stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *trimmedString2 = [trimmedString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return trimmedString2;
}

@end
