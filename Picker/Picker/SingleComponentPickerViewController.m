//
//  SingleComponentPickerViewController.m
//  Picker
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SingleComponentPickerViewController.h"

@implementation SingleComponentPickerViewController

@synthesize pickview;
@synthesize pickdata;

-(IBAction)buttonPressed{
    NSInteger row=[pickview selectedRowInComponent:0];
    NSString *select=[pickdata objectAtIndex:row];
    NSString *title=[[NSString alloc] initWithFormat:@"You select %@!",select];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:@"Thank you" delegate:nil cancelButtonTitle:@"You are welcome" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [title release];
}

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array=[[NSArray alloc] initWithObjects:@"Lisp",@"Python",@"Perl",@"C++",@"Object-C",nil];
    self.pickdata=array;
    [array release];
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
    [pickview release];
    [pickdata release];
    [super dealloc];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickdata count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView 
            titleForRow:(NSInteger)row 
           forComponent:(NSInteger)component
{
    return [pickdata objectAtIndex:row];
}

@end
