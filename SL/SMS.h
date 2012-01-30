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
    NSString *date;
}

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSString *date;

@end
