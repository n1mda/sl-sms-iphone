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
    
    UIView *view = [[UIView alloc] init];
    
    [view setFrame:CGRectMake(0, 0, 320, 80)];
    
    SSMessagesTableHeaderView *tableHeaderView = [[SSMessagesTableHeaderView alloc] init];
    [tableHeaderView.view setFrame:CGRectMake(0, 0, 320, 64)];
    [tableHeaderView setDelegate:self];
    
    tableHeaderDateView = [[SSMessagesTableHeaderDateView alloc] init];
    [tableHeaderDateView.view setFrame:CGRectMake(0, 64, 320, 15)];
    
    [view addSubview:tableHeaderView.view];
    [view addSubview:tableHeaderDateView.view];
    
    [super setTableHeaderView:view];
    
    return self;
}

#pragma mark - Managing the detail item

- (void)setSms:(SMS *)sms_ {
    [self setTitle:[sms_ sender]];
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"] autorelease]];
    [dateFormatter setDateFormat:@"d MMM yyyy HH:mm"];
    
    [tableHeaderDateView setLabelText:[dateFormatter stringFromDate:[sms date]]];
    
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
	if([sms incoming])
        return SSMessageStyleLeft;
    
    return SSMessageStyleRight;
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

#pragma mark Header View Delegate

- (void)call {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [sms trimmedSender]]]];
}

- (void)facetime {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"facetime:%@", [sms trimmedSender]]]];
}

- (void)addToContact {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Avbryt" destructiveButtonTitle:nil otherButtonTitles:@"Skapa ny kontakt", @"Lägg till i befintlig kontakt", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
    popupQuery.tag = 1;
    
    [popupQuery showInView:self.view];
    [popupQuery release];
}

- (void)addNewContact {
    // Creating new entry
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordRef person = ABPersonCreate();
        
    // Adding phone numbers
    ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneNumberMultiValue, [sms sender], (CFStringRef)@"mobil", NULL);
    ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
    CFRelease(phoneNumberMultiValue);
    
    // Adding person to the address book
    ABAddressBookAddRecord(addressBook, person, nil);
    CFRelease(addressBook);
    
    // Creating view controller for a new contact
    ABNewPersonViewController *c = [[ABNewPersonViewController alloc] init];
    [c setNewPersonViewDelegate:self];
    [c setDisplayedPerson:person];
    CFRelease(person);
    [self.navigationController presentModalViewController:c animated:YES];
    [c release];

}

- (void)addToExistingContact {
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(actionSheet.tag == 1) {
        switch (buttonIndex) {
            case 0:
                // Create new contact
                [self addNewContact];
                break;
            case 1:
                // Add to existing
                [self addToExistingContact];
                break;
            default:
                break;
        }
    }
    
    
}

	
@end
