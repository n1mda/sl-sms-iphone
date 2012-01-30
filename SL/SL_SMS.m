//
//  SMS.m
//  SL SMS
//
//  Created by Axel Moller on 1/16/12.
//  Copyright (c) 2012 Root at Everything. All rights reserved.
//

#import "SL_SMS.h"
#include <stdlib.h>

@implementation SL_SMS

// EG. från telenummer 72-150 76 52
// randomint1 är 7
// randomint2 är 6
// randomint3 är 5
// randomint4 är 2
- (SMS *)createSLMessageWithReduced:(BOOL)reduced zones:(NSArray *)zones {
    
    SMS *sms = [[SMS alloc] init];
    
    NSArray *textBase = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", 
                         @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",  nil];
    
    // Get current date and time
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    
    // Generate random integers for checksum etc
    
    // 1. Used as char, in phone number and -3 in checksum
    NSInteger randomint1 = (arc4random() % 6) + 3;
    
    // 2. Used in phonenumber
    NSInteger randomint2 = arc4random() % 9;
    
    // 3. Used after time in SMS, in phonenumber and in checksum
    NSInteger randomint3 = arc4random() % 9;
    
    // 4. Used after time in SMS, in phonenumber and in checksum
    NSInteger randomint4 = arc4random() % 9;
    
    // 5. Used in row 1 as numeric checksum
    NSInteger randomint5 = (arc4random() % 89999999) + 100000000;
    
    // 6. Used in row 2 as numeric checksum
    NSInteger randomint6 = (arc4random() % 89999999) + 100000000;
    
    // 7. Used in row 3 as numeric checksum
    NSInteger randomint7 = (arc4random() % 89999999) + 100000000;
    
    // Seven random characters, used in checksum
    NSMutableString *randomString = [[NSMutableString alloc] init];
    for (int i = 0; i < 7; i++) {
        NSInteger somerandom = arc4random() % [textBase count];        
        [randomString appendString:[textBase objectAtIndex:somerandom]];
    }
    NSLog(@"Random: %@", randomString);
    
    // Prices for different zones, 1 zone (36 sek), 2 zones (54 sek), 3 zones (72 sek)
    NSArray *prices = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:36], [NSNumber numberWithInt:54], [NSNumber numberWithInt:72], nil];
    
    // If reduced, duplicate with this number
    float reducedPriceFactor = 0.5555555555555556;
    
    // 1 zone (valid 75 min), 2 zones (valid 75 min), 3 zones (valid 120 min)
    NSArray *timeValid = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:75], [NSNumber numberWithInt:75], [NSNumber numberWithInt:120], nil];

    
    NSArray *months = [[NSArray alloc] initWithObjects:@"jan", @"feb", @"mar", @"apr", @"maj", @"jun", @"jul", @"aug", @"sep", @"okt", @"nov", @"dec", nil];
    
    NSString *monthName = [months objectAtIndex:month-1];
    
    NSString *priceText;
    NSString *priceText2;
    NSInteger price = 0;
    
    if(reduced) {
        // R
        
        priceText = @"R";
        priceText2 = @"RED PRIS";
                
        price = (NSInteger )[[prices objectAtIndex:[zones count]-1] integerValue] * reducedPriceFactor;
        
    } else {
        // H
        
        priceText = @"H";
        priceText2 = @"Helt pris";
        
        price = (NSInteger )[[prices objectAtIndex:[zones count]-1] integerValue];
    }
    
    // Month char, used in check sum
    // 1533_A_16112J5B2TUE
    NSString *monthChar = [textBase objectAtIndex:month-1];
    
    // Order day
    // 1533A_16_112J5B2TUE
    NSString *orderDay;
    if(day < 10)
        orderDay = [NSString stringWithFormat:@"0%d", day];
    else
        orderDay = [NSString stringWithFormat:@"%d", day];
        
    // Order hour
    // _15_33A16112J5B2TUE
    NSString *orderHour;
    if(hour < 10)
        orderHour = [NSString stringWithFormat:@"0%d", hour];
    else
        orderHour = [NSString stringWithFormat:@"%d", hour];
    
    // Order minute
    // 15_33_A16112J5B2TUE
    NSString *orderMinute;
    if(minute < 10)
        orderMinute = [NSString stringWithFormat:@"0%d", minute];
    else
        orderMinute = [NSString stringWithFormat:@"%d", minute];
    
    
    NSDate *now = [NSDate date];
    NSDate *validDate = [now dateByAddingTimeInterval:60*[[timeValid objectAtIndex:[zones count]-1] integerValue]];
    
    NSLog(@"Date: %@", validDate);
    
    NSDateComponents *validDateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:validDate];
    
    NSInteger validYear = [validDateComponents year];
    NSInteger validMonth = [validDateComponents month];
    
    NSString *validMonthStr;
    if(validMonth < 10)
        validMonthStr = [NSString stringWithFormat:@"0%d", validMonth];
    else
        validMonthStr = [NSString stringWithFormat:@"%d", validMonth];
    
    NSInteger validDay = [validDateComponents day];
    
    NSString *validDayStr;
    if(validDay < 10)
        validDayStr = [NSString stringWithFormat:@"0%d", validDay];
    else
        validDayStr = [NSString stringWithFormat:@"%d", validDay];
    
    NSInteger validHour = [validDateComponents hour];
    
    NSString *validHourStr;
    if(validHour < 10)
        validHourStr = [NSString stringWithFormat:@"0%d", validHour];
    else
        validHourStr = [NSString stringWithFormat:@"%d", validHour];
    
    NSInteger validMinute = [validDateComponents minute];
    
    NSString *validMinuteStr;
    if(validMinute < 10)
        validMinuteStr = [NSString stringWithFormat:@"0%d", validMinute];
    else
        validMinuteStr = [NSString stringWithFormat:@"%d", validMinute];
        
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@%d%d%d%@", orderHour, orderMinute, monthChar, orderDay, randomint3, randomint1-3, randomint4, randomString];
    NSLog(@"Checksum: %@", checksum);
    
    // priceText-zones validityHour:validityMinute randomint3randomint4
    // +'randomint5'+
    // +'randomint6'+
    // +'randomint7'+
    // SL biljett giltig till validHour:validMinute-validYear-validMonth-ValidDay
    // priceText2 price kr ink 6% moms
    // checksum
    // http://mobil.sl.se
    
    NSString *zonesString = [[zones valueForKey:@"description"] componentsJoinedByString:@""];
    NSString *returnString = [NSString stringWithFormat:@"%@-%@ %@:%@ %d%d\n+'%d'+\n+'%d'+\n+'%d'+\nSL biljett giltig till %@:%@ %d-%@-%@\n%@ %d kr ink 6%% \nmoms\n%@\nhttp://mobil.sl.se", priceText, zonesString, validHourStr, validMinuteStr, randomint3, randomint4,
                              randomint5, randomint6, randomint7,
                              validHourStr, validMinuteStr, validYear, validMonthStr, validDayStr,
                              priceText2, price, checksum];
    
    [sms setMessage:returnString];
    [sms setSender:[NSString stringWithFormat:@"72-150 %d%d %d%d", randomint1, randomint2, randomint4, randomint4]];
    [sms setDate:[NSString stringWithFormat:@"%@ %@ %d %@:%@", orderDay, monthName, year, orderHour, orderMinute]];
    
    return sms;
}

@end
