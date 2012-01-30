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
    NSMutableArray *zones;
    
    IBOutlet UISwitch *reduced;
    
    IBOutlet UISwitch *aZone;
    IBOutlet UISwitch *bZone;
    IBOutlet UISwitch *cZone;
    
    id _adBannerView;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, copy) NSMutableArray *zones;

@property (nonatomic, retain) IBOutlet UISwitch *reduced;

@property (nonatomic, retain) IBOutlet UISwitch *aZone;
@property (nonatomic, retain) IBOutlet UISwitch *bZone;
@property (nonatomic, retain) IBOutlet UISwitch *cZone;

@property (nonatomic, retain) id adBannerView;

- (IBAction)generate:(id)sender;

@end
