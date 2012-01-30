//
//  MasterViewController.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"

@class DetailViewController;

@interface MasterViewController : UIViewController <ADBannerViewDelegate> {
    NSArray *zoneSwitches;
    NSMutableArray *zones;
    UISwitch *reduced;
    
    id _adBannerView;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, copy) NSMutableArray *zones;

@property (nonatomic, retain) IBOutlet UISwitch *reduced;

@property (nonatomic, retain) IBOutletCollection(UISwitch) NSArray *zoneSwitches;

@property (nonatomic, retain) id adBannerView;

- (IBAction)generate:(id)sender;

@end
