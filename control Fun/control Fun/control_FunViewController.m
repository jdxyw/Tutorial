//
//  control_FunViewController.m
//  control Fun
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "control_FunViewController.h"

@implementation control_FunViewController

@synthesize nameField;
@synthesize passField;
@synthesize silderLabel;
@synthesize leftswitch;
@synthesize rightswitch;
@synthesize switchview;
@synthesize doSomethingButton;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

-(IBAction)dosomething:(id)sender{
    UIActionSheet *actionsheet=[[UIActionSheet alloc]
                                initWithTitle:@"Are you sure?" 
                                delegate:self 
                                cancelButtonTitle:@"No, I don't" 
                                destructiveButtonTitle:@"Yes, do it!" 
                                otherButtonTitles:nil,nil];
    [actionsheet showInView:self.view];
    [actionsheet release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex == [actionSheet cancelButtonIndex])
    {
        NSString *msg=nil;
        msg=@"Just want to say hello world";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Do something done" 
                                                    message:msg 
                                                    delegate:self 
                                                    cancelButtonTitle:@"Phew!" 
                                                    otherButtonTitles:nil, 
                                                    nil];
        [alert show];
        [alert release];
        [msg release];
    }
}

-(IBAction)switchChanged:(id)sender{
    UISwitch *whichSwitch=(UISwitch *)sender;
    BOOL setting=whichSwitch.isOn;
    [leftswitch setOn:setting animated:YES];
    [rightswitch setOn:setting animated:YES];
}
-(IBAction)toggleShowHide:(id)sender{
    UISegmentedControl *segmentControl=(UISegmentedControl *)sender;
    NSInteger segment=segmentControl.selectedSegmentIndex;
    if(segment == kShowSegmentIndex)
    {
        [switchview setHidden:NO];
    }
    else
    {
        [switchview setHidden:YES];
    }
}

-(IBAction)textFielDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

-(IBAction)backgroundClcik:(id)sender{
    [nameField resignFirstResponder];
    [passField resignFirstResponder];
}

-(IBAction)sliderChange:(id)sender{
    UISlider *slider=(UISlider *)sender;
    int progress=(int)(slider.value+0.5);
    NSString *newText=[[NSString alloc] initWithFormat:@"%d",progress];
    silderLabel.text=newText;
    //[newText dealloc];
}

@end
