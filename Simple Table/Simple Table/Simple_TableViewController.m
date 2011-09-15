//
//  Simple_TableViewController.m
//  Simple Table
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Simple_TableViewController.h"

@implementation Simple_TableViewController

@synthesize listdata;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
    NSArray *array=[[NSArray alloc] initWithObjects:@"Lisp",@"Python",@"Perl",@"Mac",@"Windows"
                    ,@"Object-C",@"C++",@"C",@"Java",@"C#",@"VB",@"J#",@"Fortan",@"Lisp",@"Python",@"Perl",@"Mac",@"Windows"
                    ,@"Object-C",@"C++",@"C",@"Java",@"C#",@"VB",@"J#",nil];
    self.listdata=array;
    [array release];
    [super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listdata count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentier=@"simpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleIdentier];
    if(cell==nil){
        cell=[[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:simpleIdentier] autorelease];
    }
    NSUInteger row=[indexPath row];
    cell.text=[listdata objectAtIndex:row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row=[indexPath row];
    NSString *rowvalue=[self.listdata objectAtIndex:row];
    NSString *message=[[NSString alloc] initWithFormat:@"You select %@",rowvalue];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:message message:message delegate:nil cancelButtonTitle:@"Yes I did" otherButtonTitles:nil, nil];
    [alert show];
    [message release];
    [alert release];
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
