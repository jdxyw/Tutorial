//
//  UserSettingViewController.m
//  UserSetting
//
//  Created by jdxyw on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserSettingViewController.h"

@implementation UserSettingViewController

@synthesize slider;
@synthesize segmentController;
@synthesize field;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

 //Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSInteger segmentIndex=[[NSUserDefaults standardUserDefaults] integerForKey:@"segmentvalue"];
    NSInteger slidervalue=[[NSUserDefaults standardUserDefaults] integerForKey:@"slidervalue"];
    NSString *str=[[NSUserDefaults standardUserDefaults] valueForKey:@"textvalue"];
    
    [slider setValue:(float)slidervalue];
    [segmentController setSelectedSegmentIndex:segmentIndex];
    [field setText:str];
    [str release];
    [super viewDidLoad];
}


-(IBAction)sliderValueChange:(id)sender
{
    NSInteger value=(NSInteger)[slider value];
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"slidervalue"];
}



-(IBAction)textFieldFinishEditing:(id)sender
{
    NSString *textValue=[field text];
    [[NSUserDefaults standardUserDefaults] setValue:textValue forKey:@"textvalue"];
    //[textValue release];
    [sender resignFirstResponder];
}

-(IBAction)segmentChange:(id)sender{
    NSInteger segmentIndex=[segmentController selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setInteger:segmentIndex forKey:@"segmentvalue"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
