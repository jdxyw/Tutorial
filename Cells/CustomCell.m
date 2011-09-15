//
//  CustomCell.m
//  Cells
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize nameLabel;
@synthesize colorLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
