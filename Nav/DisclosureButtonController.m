//
//  DisclosureButtonController.m
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DisclosureButtonController.h"
#import "DisclosureDetailController.h"
#import "NavAppDelegate.h"

@implementation DisclosureButtonController

@synthesize list;

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
    NSArray *arrar=[[NSArray alloc] initWithObjects:@"Toy Story",@"a bug's life",@"Toy Story 2",@"Cars",@"Find Nemo",nil ];
    self.list=arrar;
    [arrar release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DisclosureButtonCellIdentifier=@"DisclosureButtonCellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:DisclosureButtonCellIdentifier];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:DisclosureButtonCellIdentifier]autorelease];
    }
    
    NSUInteger row=[indexPath row];
    NSString *rowString=[list objectAtIndex:row];
    cell.textLabel.text=rowString;
    [rowString release];
    return cell;
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDetailDisclosureButton;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Do you see the button" message:@"If you are trying to drill down, touch that instead" delegate:nil cancelButtonTitle:@"What happen" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(childcontroller == nil)
    {
        childcontroller=[[DisclosureDetailController alloc] initWithNibName:@"DisclosureDetailController" bundle:nil];
    }
        childcontroller.title=@"disclousre button pressed";
        NSUInteger row=[indexPath row];
        
        NSString *movie=[list objectAtIndex:row];
        NSString *message=[[NSString alloc] initWithFormat:@"You select the movie %@",movie];
        childcontroller.message=message;
        childcontroller.title=movie;
        [message release];
        NavAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
        [delegate.navController pushViewController:childcontroller animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [list release];
    [childcontroller release];
    [super dealloc];
}

@end
