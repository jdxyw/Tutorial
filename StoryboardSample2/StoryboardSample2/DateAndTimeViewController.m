//
//  DateAndTimeViewController.m
//  StoryboardSample2
//
//  Created by jdxyw on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DateAndTimeViewController.h"

@implementation DateAndTimeViewController
@synthesize dateLabel;
@synthesize timeLabel;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    NSDate *now=[NSDate date];
    dateLabel.text=[NSDateFormatter localizedStringFromDate:now dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    timeLabel.text=[NSDateFormatter localizedStringFromDate:now dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}

- (void)viewDidUnload
{
    [self setDateLabel:nil];
    [self setTimeLabel:nil];
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
