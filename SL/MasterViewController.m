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

@synthesize zoneSwitches, zones;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
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
    
    UIBarButtonItem *closebutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
    
    [self.navigationItem setLeftBarButtonItem:closebutton];
    
    [closebutton release];
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"Generera" style:UIBarButtonItemStyleBordered target:self action:@selector(generate:)];
    
    [self.navigationItem setRightBarButtonItem:createButton];
    
    [createButton release];
}

- (void)close {
    [self.navigationController dismissModalViewControllerAnimated:YES];
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
    
    zones = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (UISwitch *zoneSwitch in zoneSwitches) {
        if (zoneSwitch.on) {
            unichar zone = 'A' + zoneSwitch.tag;
            [zones addObject:[NSString stringWithCharacters:&zone length:1]];
        }
    }
	
    [zones sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    if(![zones count]) {
        return;
    }
    
    SMS *sentSMS = [[SMS alloc] init];
    [sentSMS setDate:[NSDate date]];
    [sentSMS setSender:@"72-150"];
    [sentSMS setMessage:[NSString stringWithFormat:@"%@%@", reduced.on ? @"R" : @"H", [[zones valueForKey:@"description"] componentsJoinedByString:@""]]];
    
    [sentSMS setIncoming:NO];
    
    [delegate addSMSMessage:sentSMS];
    
    SL_SMS *sl = [[SL_SMS alloc] init];
    SMS *sms = [sl createSLMessageWithReduced:reduced.on zones:zones];
    [sms setIncoming:YES];
    
    [delegate addSMSMessage:sms];
    
    [zones release];
    
    [self close];
}

@end
