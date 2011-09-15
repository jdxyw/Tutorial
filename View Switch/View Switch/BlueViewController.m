//
//  BlueViewController.m
//  View Switch
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BlueViewController.h"

@implementation BlueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)blueButtonPressed:(id)sender{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Blue Button is pressed" message:@"You press the blue button" delegate:nil cancelButtonTitle:@"Yes, I did" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
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

@end
