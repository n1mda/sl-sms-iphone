//
//  MasterViewController.m
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "SL_SMS.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

@synthesize reduced;

@synthesize aZone, bZone, cZone, zones;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [aZone release], [bZone release], [cZone release], [reduced release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setTitle:@"Meddelanden"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (IBAction)generate:(id)sender {
    
    zones = [[NSMutableArray alloc] init];
    
    if(aZone.on) [zones addObject:@"A"];
    if(bZone.on) [zones addObject:@"B"];
    if(bZone.on) [zones addObject:@"C"];
    
    if([zones count] == 0) {
        return;
    }
    
    SL_SMS *sl = [[SL_SMS alloc] init];
    SMS *sms = [sl createSLMessageWithReduced:reduced.on zones:zones];
    
    DetailViewController *detailViewController = [[[DetailViewController alloc] init] autorelease];
    [detailViewController setSms:sms];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [zones release];
}

@end
