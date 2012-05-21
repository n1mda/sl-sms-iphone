//
//  SSMessagesTableHeaderView.m
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SSMessagesTableHeaderView.h"

@implementation SSMessagesTableHeaderView

@synthesize delegate;
@synthesize messageImageView;
@synthesize callButton, facetimeButton, addContactButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    // Call button
    callButton = [UIButton buttonWithType:117];
    [callButton setFrame:CGRectMake(6, 7, 100, 33)];
    [callButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [callButton setTitleColor:[UIColor colorWithRed:0.337 green:0.412 blue:0.58 alpha:1] forState:UIControlStateNormal];
    [callButton setTitle:@"Ring" forState:UIControlStateNormal];
    [callButton addTarget:delegate action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:callButton];
    [callButton retain];
    
    // Facetime button (if device > 4)
    facetimeButton = [UIButton buttonWithType:117];
    [facetimeButton setFrame:CGRectMake(111, 7, 100, 33)];
    [facetimeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [facetimeButton setTitleColor:[UIColor colorWithRed:0.337 green:0.412 blue:0.58 alpha:1] forState:UIControlStateNormal];
    [facetimeButton setTitle:@"Facetime" forState:UIControlStateNormal];
    [facetimeButton addTarget:delegate action:@selector(facetime) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:facetimeButton];
    [facetimeButton retain];
    
    // Add contact button
    addContactButton = [UIButton buttonWithType:117];
    [addContactButton setFrame:CGRectMake(215, 7, 100, 33)];
    [addContactButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [addContactButton setTitleColor:[UIColor colorWithRed:0.337 green:0.412 blue:0.58 alpha:1] forState:UIControlStateNormal];
    [addContactButton setTitle:@"Lägg till" forState:UIControlStateNormal];
    [addContactButton addTarget:delegate action:@selector(addToContact) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addContactButton];
    [addContactButton retain];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return YES;
    
    return NO;
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    NSLog(@"Orientation changed");
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(UIDeviceOrientationIsLandscape(orientation) || orientation == UIDeviceOrientationPortraitUpsideDown) {
        [callButton setFrame:CGRectMake(6, 9, 151, 33)];
        [facetimeButton setFrame:CGRectMake(162, 9, 151, 33)];
        [addContactButton setFrame:CGRectMake(319, 9, 151, 33)];
        
        [messageImageView setImage:[UIImage imageNamed:@"tableheaderview_message_landscape.png"]];
        [messageImageView setFrame:CGRectMake(0, 41, 480, 23)];
    } else {
        [callButton setFrame:CGRectMake(6, 7, 100, 33)];
        [facetimeButton setFrame:CGRectMake(111, 7, 100, 33)];
        [addContactButton setFrame:CGRectMake(215, 7, 100, 33)];

        [messageImageView setImage:[UIImage imageNamed:@"tableheaderview_message.png"]];
        [messageImageView setFrame:CGRectMake(0, 41, 320, 23)];
    }
    
}

- (IBAction)call:(id)sender {
    [delegate call];
}

- (IBAction)facetime:(id)sender {
    [delegate facetime];
}

- (IBAction)addToContact:(id)sender {
    [delegate addToContact];
}

@end
