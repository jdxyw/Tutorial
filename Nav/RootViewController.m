//
//  RootViewController.m
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonController.h"
#import "CheckListController.h"
#import "RowControlsController.h"
#import "MoveMeController.h"
#import "NavAppDelegate.h"

@implementation RootViewController

@synthesize controllers;

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RootviewControllerCell=@"RootviewControllerCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:RootviewControllerCell];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithFrame:CGRectZero
                                reuseIdentifier:RootviewControllerCell] autorelease];
    }
    
    NSUInteger row=[indexPath row];
    SecondLevelViewController *controller=[controllers objectAtIndex:row];
    cell.text=controller.title;
    //cell.image=controller.rowImage;
    return cell;
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDisclosureIndicator;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    SecondLevelViewController *control=[self.controllers objectAtIndex:row];
    
    NavAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    [delegate.navController pushViewController:control animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title=@"Root Level";
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    DisclosureButtonController *disclosurebuttoncontroller=[[DisclosureButtonController alloc] initWithStyle:UITableViewStylePlain];
    disclosurebuttoncontroller.title=@"Disclosure Buttons";
    [array addObject:disclosurebuttoncontroller];
    [disclosurebuttoncontroller release];
    
    CheckListController *checklistcontroller=[[CheckListController alloc] initWithStyle:UITableViewStylePlain];
    checklistcontroller.title=@"Check List view";
    [array addObject:checklistcontroller];
    [checklistcontroller release];
    
    RowControlsController *rowcontroller=[[RowControlsController alloc] initWithStyle:UITableViewStylePlain];
    rowcontroller.title=@"Row control controller";
    [array addObject:rowcontroller];
    [rowcontroller release];
    
    MoveMeController *movemecontroller=[[MoveMeController alloc] initWithStyle:UITableViewStylePlain];
    movemecontroller.title=@"Move me";
    [array addObject:movemecontroller];
    [movemecontroller release];
    
    self.controllers=array;
    [array release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)dealloc
{
    [controllers release];
    [super dealloc];
}

@end
