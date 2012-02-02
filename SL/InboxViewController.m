//
//  InboxViewController.m
//  SL
//
//  Created by Axel Möller on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InboxViewController.h"
#import "MessageTableViewCell.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation InboxViewController

@synthesize smses;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)createNewMessage {
    MasterViewController *masterViewController = [[MasterViewController alloc] init];
    
    [masterViewController setDelegate:self];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    
    [self.navigationController presentModalViewController:navController animated:YES];
}

- (void)addSMSMessage:(SMS *)message {
    
    [smses insertObject:message atIndex:0];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.886 green:0.906 blue:0.929 alpha:1]]; /*#e2e7ed*/

    [self setTitle:@"Meddelanden"];
    
    smses = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Ändra" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.navigationItem setLeftBarButtonItem:editButton];
    [editButton release];
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createNewMessage)];
    
    [self.navigationItem setRightBarButtonItem:newButton];
    [newButton release];
    
    NSMutableArray *names = [[NSMutableArray alloc] initWithObjects:@"Emma Bergqvist", @"Heidi Ahlberg", @"Marco Djelevic", @"André Nordlund", @"Karin Äng", @"Fredrik Drejek", @"Viktor Lundgren", @"Michel Grundtman", @"Julia Sara", @"Jesper Olsson", @"Malin Falck", @"Joe Touma", @"Johan Holmgren", @"Sebatiana Gustafsson", nil]; // 14 names
    
    
    NSUInteger firstObject = 0;
    for (int i = 0; i<[names count];i++) {
        NSUInteger randomIndex = random() % [names count];
        [names exchangeObjectAtIndex:firstObject withObjectAtIndex:randomIndex];
        firstObject +=1;
    }
    
    NSMutableArray *messages = [[NSMutableArray alloc] initWithObjects:@"Ja ringer sen", @"Hahah", @"lol jag vet", @"Kan du komma imorn?", @"Ja jag kommer snart", @"Ring mig senare", @"såg du senaste avsnittet? var helt okej.", @"Asgött. grattis!", @"Vad ska ni göra ikväll?", @":)", @"Skickar det på mailen", @"Kolla kanal 5 nu!", @"Haha aa", @"mm ja håller med", nil]; // 14 names
    
    firstObject = 0;    
    for (int i = 0; i<[messages count];i++) {
        NSUInteger randomIndex = random() % [messages count];
        [messages exchangeObjectAtIndex:firstObject withObjectAtIndex:randomIndex];
        firstObject +=1;
    }
    
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    NSDate *now = [NSDate date];
    NSDate *previousDate = now;
    
    for(int i = 0; i < 14; i++) {
        int random = arc4random() % 120;
        NSDate *someTime = [previousDate dateByAddingTimeInterval:-(60*random)];
        previousDate = someTime;
        [dates addObject:someTime];
    }
    
    
    for( int i = 0; i < [names count]; i++) {
        SMS *sms = [[SMS alloc] init];
        
        [sms setSender:[names objectAtIndex:i]];
        [sms setMessage:[messages objectAtIndex:i]];
        [sms setDate:[dates objectAtIndex:i]];
        [sms setIncoming:YES];
        
        [smses addObject:sms];
        
        [sms release];
    }
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [smses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
        
    [cell.textLabel setText:[[smses objectAtIndex:indexPath.row] sender]];
    [cell.detailTextLabel setText:[[smses objectAtIndex:indexPath.row] message]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 64, 4, 100, 20)];
    [dateLabel setFont:[UIFont systemFontOfSize:13.0]];
    [dateLabel setTextColor:[UIColor colorWithRed:0.165 green:0.455 blue:0.851 alpha:1]]; /*#2a74d9*/

    NSDate *date = [[smses objectAtIndex:indexPath.row] date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *time = [dateFormatter stringFromDate:date];
    
    NSDateFormatter *yesterDayFormatter = [[NSDateFormatter alloc] init];
    [yesterDayFormatter setDateFormat:@"dd"];
    
    NSString *today = [yesterDayFormatter stringFromDate:[NSDate date]];
    NSString *yesterday = [yesterDayFormatter stringFromDate:date];
    
    if([yesterday integerValue] < [today integerValue])
        time = @"igår";
    
    [dateLabel setText:time];
    
    [cell addSubview:dateLabel];
    [dateLabel release];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor whiteColor]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    [detailViewController setSms:[smses objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}

@end
