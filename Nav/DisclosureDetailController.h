//
//  DisclosureDetailController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclosureDetailController : UIViewController
{
    IBOutlet UILabel *label;
    NSString *message;
}

@property (nonatomic,retain) IBOutlet UILabel *label;
@property (nonatomic,retain) NSString *message;

@end
