//
//  IFSViewController.h
//  GPUBase
//
//  Created by jdxyw on 11-12-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFSViewController : UIViewController
{
    IBOutlet UIImageView *imgView;
    IBOutlet UIButton *button;
    //UIImage *image;
}

@property (nonatomic,retain) UIImageView *imgView;
@property (nonatomic,retain) UIButton *button;

-(IBAction)buttonClick:(id) sender;

@end
