//
//  DetailViewController.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMessagesViewController.h"
#import "SSMessagesTableHeaderDateView.h"
#import "SMS.h"

@interface DetailViewController : SSMessagesViewController {
    SMS *sms;
    SSMessagesTableHeaderDateView *tableHeaderDateView;
}

@property (nonatomic, retain) SMS *sms;
@property (nonatomic, retain) SSMessagesTableHeaderDateView *tableHeaderDateView;

- (void)setSms:(SMS *)sms_;

- (IBAction)call:(id)sender;
- (IBAction)facetime:(id)sender;
- (IBAction)addContact:(id)sender;

@end
