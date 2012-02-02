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
}

@property (nonatomic, retain) NSMutableArray *smses;

- (void)addSMSMessage:(SMS *)message;

@end
