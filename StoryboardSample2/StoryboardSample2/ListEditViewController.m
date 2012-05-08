//
//  ListEditViewController.m
//  StoryboardSample2
//
//  Created by jdxyw on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListEditViewController.h"

@implementation ListEditViewController
@synthesize editText;
@synthesize preViewController;
@synthesize selection;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    editText.text = [selection objectForKey:@"object"]; 
    [editText becomeFirstResponder]; 
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated]; 
    
    if ([preViewController respondsToSelector:@selector(setEditedSelection:)]) {
        //结束编辑
        [editText endEditing:YES];
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"];
        id object = editText.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys:
                                         indexPath, @"indexPath",
                                         object, @"object",
                                         nil];
        //设置上一个ViewController中的editedSelection，由于设置editedSelection方法
        //已经重写，从而对应在表格中的数据会发生变化
        [preViewController setValue:editedSelection forKey:@"editedSelection"];
    }
}

- (void)viewDidUnload
{
    [self setEditText:nil];
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
