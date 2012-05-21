//
//  SMS.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMS : NSObject {
    NSString *message;
    NSString *sender;
    NSDate *date;
    
    NSArray *links;
    
    BOOL incoming;
}

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSDate *date;

@property (nonatomic, retain) NSArray *links;

@property (nonatomic) BOOL incoming;

- (NSString *)trimmedSender;

@end
