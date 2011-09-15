//
//  SwitchViewcontroller.m
//  View Switch
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewcontroller.h"
#import "YellowViewController.h"
#import "BlueViewController.h"

@implementation SwitchViewcontroller

@synthesize bluecontroller;
@synthesize yellowcontroller;

-(void)viewDidLoad{
    BlueViewController *blueview=[[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
    self.bluecontroller=blueview;
    [self.view insertSubview:blueview.view atIndex:0];
    [blueview release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*-(IBAction)switchViews:(id)sender{
    if(self.yellowcontroller == nil)
    {
        YellowViewController *yellowview=[[YellowViewController alloc] initWithNibName:@"YellowViewcontroller" bundle:nil];
        self.yellowcontroller=yellowview;
        [self.view insertSubview:yellowview.view atIndex:0];
        [yellowview release];
    }
    
    if(self.bluecontroller.view.superview == nil)
    {
        [yellowcontroller.view removeFromSuperview];
        [self.view insertSubview:bluecontroller.view atIndex:0];
    }
    else
    {
        [bluecontroller.view removeFromSuperview];
        [self.view insertSubview:yellowcontroller.view atIndex:0];
    }
}*/

-(IBAction)switchViews:(id)sender{
    if(self.yellowcontroller == nil)
    {
        YellowViewController *yellowview=[[YellowViewController alloc] initWithNibName:@"YellowViewcontroller" bundle:nil];
        self.yellowcontroller=yellowview;
        [self.view insertSubview:yellowview.view atIndex:0];
        [yellowview release];
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(self.bluecontroller.view.superview == nil)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [bluecontroller viewWillAppear:YES];
        [yellowcontroller viewWillDisappear:YES];
        [yellowcontroller.view removeFromSuperview];
        [self.view insertSubview:bluecontroller.view atIndex:0];
        [yellowcontroller viewDidDisappear:YES];
        [bluecontroller viewDidAppear:YES];
    }
    else
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [yellowcontroller viewWillAppear:YES];
        [bluecontroller viewWillDisappear:YES];
        [bluecontroller.view removeFromSuperview];
        [self.view insertSubview:yellowcontroller.view atIndex:0];
        [bluecontroller viewDidDisappear:YES];
        [yellowcontroller viewDidAppear:YES];
    }
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



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
    [yellowcontroller release];
    [bluecontroller release];
    [super dealloc];
}

@end
