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
#import "WireFrameSphere.h"
#import "GLPainterController.h"
#import "IFSViewController.h"

@implementation RootViewController

@synthesize effects;

- (void)viewDidLoad
{
    effects=[[NSArray alloc] initWithObjects:@"Deform", @"Monjori",@"Star",@"Twist",@"Kaleidoscope",
             @"Z Invert",@"Tunnel",@"Relief Tunnel",@"Square Tunnel",@"Fly",@"Pluse",
             @"Montion Blur",@"Post Processing",@"Julia",@"Mandel",@"Flower",@"Metablob",
             @"Plasma",@"Clod",@"Deformation 1",@"Deformation 2",@"Deformation 3",
             @"Deformation 4",@"Deformation 5",@"Deformation 6",@"Deformation 7",
             @"3D Shader",@"WireFrame Sphere",@"GL Paint",@"Fractal One",@"Fractal Two",
             @"Fractal Three",@"Fractal Four",@"Fractal Five",@"Fractal Six",
             @"Fractal Seven",@"Fractal Eight",@"Fractal Nine",@"Fractal Ten",
             @"Fractal Eleven",@"Fractal Twelve",@"Fractal Thirteen",@"Fractal Fourteen",
             @"Fractal Fiftyteen",@"Fractal Sixteen",@"Fractal Seventeen",@"Fractal Eighteen",
             @"Fractal Nineteen",@"Fractal Twenty",@"Fractal Twenty-One",@"Fractal Twenty-Two",
             @"Fractal Twenty-Three",@"Fractal Twenty-Four",@"Fractal Twenty-Five",
             @"Fractal Twenty-Six",@"Fractal Twenty-Seven",@"Fractal Twenty-Eight",@"Fractal Twenty-Nine",
             @"Fractal Thirty",@"Fractal Thirty-One",@"Fractal Thirty-Two",@"Fractal Thirty-Three",
             @"Fractal Thirty-Four",@"Fractal Thirty-Five",@"Fractal Thirty-Six",@"Fractal Thirty-Seven",
             @"Fractal Thirty-Eight",@"Fractal Thirty-Nine",@"Fractal Forty",@"Fractal Forty-One",@"IFS One",nil];
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
        
        case 19:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation1" fragment:@"Deformation1"];
            detailViewController.title=@"Deformation 1";
            break;
            
        case 20:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation2" fragment:@"Deformation2"];
            detailViewController.title=@"Deformation 2";
            break;
        
        case 21:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation3" fragment:@"Deformation3"];
            detailViewController.title=@"Deformation 3";
            break;
        
        case 22:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation4" fragment:@"Deformation4"];
            detailViewController.title=@"Deformation 4";
            break;
        
        case 23:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation5" fragment:@"Deformation5"];
            detailViewController.title=@"Deformation 5";
            break;
        
        case 24:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation6" fragment:@"Deformation6"];
            detailViewController.title=@"Deformation 6";
            break;
            
        case 25:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Deformation7" fragment:@"Deformation7"];
            detailViewController.title=@"Deformation 7";
            break;
            
        case 26:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"TreeDShader1" fragment:@"TreeDShader1"];
            detailViewController.title=@"3D Shader";
            break;
        
        case 27:
            detailViewController=[[WireFrameSphere alloc] init];
            [detailViewController setFileName:@"WireFrameSphere" fragment:@"WireFrameSphere"];
            detailViewController.title=@"WireFrame Sphere";
            break;
            
        case 28:
            detailViewController=[[GLPainterController alloc] init];
            [detailViewController.view setBrushColorWithRed:1.0 green:0.5 blue:0,2];
            //[detailViewController setFileName:@"WireFrameSphere" fragment:@"WireFrameSphere"];
            detailViewController.title=@"WireFrame Sphere";
            break;
            
        case 29:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal1" fragment:@"Fractal1"];
            detailViewController.title=@"Fractal1";
            break;
            
        case 30:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal2" fragment:@"Fractal2"];
            detailViewController.title=@"Fractal2";
            break;
            
        case 31:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal3" fragment:@"Fractal3"];
            detailViewController.title=@"Fractal3";
            break;
            
        case 32:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal4" fragment:@"Fractal4"];
            detailViewController.title=@"Fractal4";
            break;
            
        case 33:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal5" fragment:@"Fractal5"];
            detailViewController.title=@"Fractal5";
            break;
            
        case 34:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal6" fragment:@"Fractal6"];
            detailViewController.title=@"Fractal6";
            break;
        
        case 35:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal7" fragment:@"Fractal7"];
            detailViewController.title=@"Fractal7";
            break;
            
        case 36:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal8" fragment:@"Fractal8"];
            detailViewController.title=@"Fractal8";
            break;
            
        case 37:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal9" fragment:@"Fractal9"];
            detailViewController.title=@"Fractal9";
            break;
            
        case 38:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal10" fragment:@"Fractal10"];
            detailViewController.title=@"Fractal10";
            break;
            
        case 39:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal11" fragment:@"Fractal11"];
            detailViewController.title=@"Fractal11";
            break;
            
        case 40:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal12" fragment:@"Fractal12"];
            detailViewController.title=@"Fractal12";
            break;
            
        case 41:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal13" fragment:@"Fractal13"];
            detailViewController.title=@"Fractal13";
            break;
            
        case 42:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal14" fragment:@"Fractal14"];
            detailViewController.title=@"Fractal14";
            break;

        case 43:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal15" fragment:@"Fractal15"];
            detailViewController.title=@"Fractal15";
            break;
            
        case 44:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal16" fragment:@"Fractal16"];
            detailViewController.title=@"Fractal16";
            break;
            
        case 45:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal17" fragment:@"Fractal17"];
            detailViewController.title=@"Fractal17";
            break;
            
        case 46:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal18" fragment:@"Fractal18"];
            detailViewController.title=@"Fractal18";
            break;
            
        case 47:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal19" fragment:@"Fractal19"];
            detailViewController.title=@"Fractal19";
            break;
            
        case 48:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal20" fragment:@"Fractal20"];
            detailViewController.title=@"Fractal20";
            break;

        case 49:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal21" fragment:@"Fractal21"];
            detailViewController.title=@"Fractal21";
            break;
            
        case 50:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal22" fragment:@"Fractal22"];
            detailViewController.title=@"Fractal22";
            break;
            
        case 51:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal23" fragment:@"Fractal23"];
            detailViewController.title=@"Fractal23";
            break;
            
        case 52:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal24" fragment:@"Fractal24"];
            detailViewController.title=@"Fractal24";
            break;
            
        case 53:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal25" fragment:@"Fractal25"];
            detailViewController.title=@"Fractal25";
            break;
            
        case 54:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal26" fragment:@"Fractal26"];
            detailViewController.title=@"Fractal26";
            break;
            
        case 55:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal27" fragment:@"Fractal27"];
            detailViewController.title=@"Fractal27";
            break;
            
        case 56:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal28" fragment:@"Fractal28"];
            detailViewController.title=@"Fractal28";
            break;
            
        case 57:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal29" fragment:@"Fractal29"];
            detailViewController.title=@"Fractal29";
            break;
            
        case 58:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal30" fragment:@"Fractal30"];
            detailViewController.title=@"Fractal30";
            break;
            
        case 59:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal31" fragment:@"Fractal31"];
            detailViewController.title=@"Fractal31";
            break;
            
        case 60:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal32" fragment:@"Fractal32"];
            detailViewController.title=@"Fractal32";
            break;
            
        case 61:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal33" fragment:@"Fractal33"];
            detailViewController.title=@"Fractal33";
            break;
            
        case 62:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal34" fragment:@"Fractal34"];
            detailViewController.title=@"Fractal34";
            break;

        case 63:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal35" fragment:@"Fractal35"];
            detailViewController.title=@"Fractal35";
            break;
            
        case 64:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal36" fragment:@"Fractal36"];
            detailViewController.title=@"Fractal36";
            break;
            
        case 65:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal37" fragment:@"Fractal37"];
            detailViewController.title=@"Fractal37";
            break;
            
        case 66:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal38" fragment:@"Fractal38"];
            detailViewController.title=@"Fractal38";
            break;

        case 67:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal39" fragment:@"Fractal39"];
            detailViewController.title=@"Fractal39";
            break;
            
        case 68:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal40" fragment:@"Fractal40"];
            detailViewController.title=@"Fractal40";
            break;
            
        case 69:
            detailViewController=[[PlaneDeformationController alloc] init];
            [detailViewController setFileName:@"Fractal41" fragment:@"Fractal41"];
            detailViewController.title=@"Fractal41";
            break;
            
        case 70:
            detailViewController=[[IFSViewController alloc] init];
            detailViewController.title=@"IFS 1";
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
