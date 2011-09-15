//
//  CustomCell.h
//  Cells
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *colorLabel;
}

@property (nonatomic,retain) IBOutlet UILabel *nameLabel;
@property (nonatomic,retain) IBOutlet UILabel *colorLabel;

@end
