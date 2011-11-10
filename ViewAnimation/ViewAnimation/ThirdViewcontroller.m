//
//  ThirdViewcontroller.m
//  ViewAnimation
//
//  Created by jdxyw on 11-10-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewcontroller.h"

@implementation ThirdViewcontroller

@synthesize myview;
//@synthesize field;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        change=NO;
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

-(IBAction)touchView:(id)sender{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGRect rect=[[UIScreen mainScreen] bounds];
    
    if(!change)
    {
        change=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.5f];
        [myview setFrame:CGRectMake(rect.size.width/2-80, rect.size.height/2-80,160 , 160)];
        [myview setBackgroundColor:[UIColor redColor]];
        [UIView commitAnimations];
    }
    else
    {
        change=NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.5f];
        [myview setFrame:CGRectMake(rect.size.width/2-40, rect.size.height/2-40, 80, 80)];
        [myview setBackgroundColor:[UIColor yellowColor]];
        [UIView commitAnimations];
        
    }
}

-(void)dealloc{
    [self.view release];
    [super dealloc];
}

@end
