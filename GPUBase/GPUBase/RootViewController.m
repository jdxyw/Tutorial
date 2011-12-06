//
//  RootViewController.m
//  GPUBase
//
//  Created by jdxyw on 11-12-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "DeformOpenGLController.h"
#import "MonjoriOpenGLController.h"
#import "StarOpenGLController.h"
#import "TwistOpenGLController.h"
#import "KaleidoscopeOpenGLController.h"
#import "PlaneDeformationController.h"

@implementation RootViewController

@synthesize effects;

- (void)viewDidLoad
{
    effects=[[NSArray alloc] initWithObjects:@"Deform", @"Monjori",@"Star",@"Twist",@"Kaleidoscope",
             @"Z Invert",@"Tunnel",@"Relief Tunnel",@"Square Tunnel",@"Fly",@"Pluse",
             @"Montion Blur",@"Post Processing",@"Julia",@"Mandel",@"Flower",@"Metablob",
             @"Plasma",@"Clod",nil];
    //[effects addObject:[NSString stringWithString:@"Deform"]];
    [self setTitle:@"GPU Effect"];
    [super viewDidLoad];
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

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.effects count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EffectCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease]; 
    }
    
    [cell.textLabel setText:[self.effects objectAtIndex:[indexPath row]]];

    // Configure the cell.
    return cell;
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailViewController;
    //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    switch ([indexPath row]) {
        case 0:
            detailViewController=[[DeformOpenGLController alloc] init];            detailViewController.title=@"Deform";
            break;
        case 1:
            detailViewController=[[MonjoriOpenGLController alloc] init];
            detailViewController.title=@"Monjori";
            break;
            
        case 2:
            detailViewController=[[StarOpenGLController alloc] init];
            detailViewController.title=@"Star";
            break;
        
        case 3:
            detailViewController=[[TwistOpenGLController alloc] init];
            detailViewController.title=@"Twist";
            break;
        
        case 4:
            detailViewController=[[KaleidoscopeOpenGLController alloc] init];
            detailViewController.title=@"Kaleidoscope";
            break;
            
        case 5:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:[NSString stringWithString:@"ZInvert"] fragment:[NSString stringWithString:@"ZInvert"]];
            detailViewController.title=@"Z Invert";
            break;
        
        case 6:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Tunnel" fragment:@"Tunnel"];
            detailViewController.title=@"Tunnel";
            break;
            
        case 7:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"ReliefTunnel" fragment:@"ReliefTunnel"];
            detailViewController.title=@"Relief Tunnel";
            break;
            
        case 8:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"SquareTunnel" fragment:@"SquareTunnel"];
            detailViewController.title=@"Square Tunnel";
            break;
        
        case 9:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fly" fragment:@"Fly"];
            detailViewController.title=@"Fly";
            break;
        
        case 10:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Pulse" fragment:@"Pulse"];
            detailViewController.title=@"Pulse";
            break;
            
        case 11:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"MontionBlur" fragment:@"MontionBlur"];
            detailViewController.title=@"Montion Blur";
            break;
            
        case 12:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"PostProcessing" fragment:@"PostProcessing"];
            detailViewController.title=@"Post Processing";
            break;
            
        case 13:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Julia" fragment:@"Julia"];
            detailViewController.title=@"Julia";
            break;
            
        case 14:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Mandel" fragment:@"Mandel"];
            detailViewController.title=@"Mandel";
            break;
            
        case 15:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Flower" fragment:@"Flower"];
            detailViewController.title=@"Flower";
            break;
            
        case 16:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Metablob" fragment:@"Metablob"];
            detailViewController.title=@"Metablob";
            break;
            
        case 17:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Plasma" fragment:@"Plasma"];
            detailViewController.title=@"Plasma";
            break;
            
        case 18:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Clod" fragment:@"Clod"];
            detailViewController.title=@"Clod";
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
