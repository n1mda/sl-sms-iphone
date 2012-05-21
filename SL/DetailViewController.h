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

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface DetailViewController : SSMessagesViewController <UIActionSheetDelegate, ABNewPersonViewControllerDelegate, UIGestureRecognizerDelegate> {
    SMS *sms;
    SSMessagesTableHeaderDateView *tableHeaderDateView;
}

@property (nonatomic, retain) SMS *sms;
@property (nonatomic, retain) SSMessagesTableHeaderDateView *tableHeaderDateView;

- (void)setSms:(SMS *)sms_;

- (void)call;
- (void)facetime;
- (void)addToContact;

@end
