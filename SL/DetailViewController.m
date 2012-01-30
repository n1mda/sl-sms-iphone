//
//  DetailViewController.m
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "SSMessageTableViewCellBubbleView.h"
#import "SSMessagesTableHeaderView.h"
#import "SSMessagesTableHeaderDateView.h"
#import "LinksDetailViewController.h"

@implementation DetailViewController

@synthesize sms, tableHeaderDateView;

- (void)dealloc
{
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
    SSMessagesTableHeaderView *tableHeaderView = [[SSMessagesTableHeaderView alloc] init];
    tableHeaderDateView = [[SSMessagesTableHeaderDateView alloc] init];
    
    [tableHeaderDateView.view setFrame:CGRectMake(0, tableHeaderView.view.frame.size.height, tableHeaderDateView.view.frame.size.width, tableHeaderDateView.view.frame.size.height)];
    
    [viewController.view setFrame:CGRectMake(0, 0, tableHeaderView.view.frame.size.width, tableHeaderView.view.frame.size.height + tableHeaderDateView.view.frame.size.height)];
    
    [viewController.view addSubview:tableHeaderView.view];
    [viewController.view addSubview:tableHeaderDateView.view];
    
    [super setTableHeaderView:viewController.view];
    
    [tableHeaderView release];
    [viewController release];
    
    return self;
}

#pragma mark - Managing the detail item

- (void)setSms:(SMS *)sms_ {
    [self setTitle:[sms_ sender]];
    //[super setDate:[sms_ date]];
    sms = sms_;
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
    [tableHeaderDateView setLabelText:[sms date]];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Ändra" style:UIBarButtonItemStyleBordered target:self action:@selector(editMessage)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
}

- (void)editMessage {
    [self setEditing:([self isEditing] ? NO : YES) animated:YES];
    NSLog(@"Editing: %d", [self isEditing]);
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark SSMessagesViewController

- (SSMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return SSMessageStyleRight;
	}
	return SSMessageStyleLeft;
}


- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [sms message];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    LinksDetailViewController *linksDetailViewController = [[LinksDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
    [linksDetailViewController setLinks:[(SSMessageTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] links]];
    
    [self.navigationController pushViewController:linksDetailViewController animated:YES];
}
	
@end
