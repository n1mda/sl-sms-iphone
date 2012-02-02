//
//  MasterViewController.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UIViewController {
    NSArray *zoneSwitches;
    NSMutableArray *zones;
    UISwitch *reduced;
    
    id delegate;
    
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, copy) NSMutableArray *zones;

@property (nonatomic, retain) IBOutlet UISwitch *reduced;

@property (nonatomic, retain) IBOutletCollection(UISwitch) NSArray *zoneSwitches;

@property (nonatomic, retain) id delegate;

- (IBAction)generate:(id)sender;

@end
