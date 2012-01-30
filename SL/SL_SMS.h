//
//  SMS.h
//  SL SMS
//
//  Created by Axel Moller on 1/16/12.
//  Copyright (c) 2012 Root at Everything. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMS.h"

@interface SL_SMS : NSObject

- (SMS *)createSLMessageWithReduced:(BOOL)reduced zones:(NSArray *)zones;

@end
