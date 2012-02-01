//
//  LinksDetailViewController.h
//  SL
//
//  Created by Axel Möller on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface LinksDetailViewController : UITableViewController <ABUnknownPersonViewControllerDelegate> {
    NSArray *links;
}

@property (nonatomic, retain) NSArray *links;

@end
