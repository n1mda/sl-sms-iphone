//
//  InboxViewController.h
//  SL
//
//  Created by Axel Möller on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMS.h"

@interface InboxViewController : UITableViewController {
    NSMutableArray *smses;
    
    UIBarButtonItem *newButton;
}

@property (nonatomic, retain) NSMutableArray *smses;
@property (nonatomic, retain) UIBarButtonItem *newButton;

- (void)addSMSMessage:(SMS *)message;

@end
