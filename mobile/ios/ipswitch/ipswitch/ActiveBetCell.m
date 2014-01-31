//
//  ActiveBetCell.m
//  ipswitch
//
//  Created by Cevaris on 12/8/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "ActiveBetCell.h"

@implementation ActiveBetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblFriendUsername.adjustsFontSizeToFitWidth = YES;
        
        self.lblTitle.adjustsFontSizeToFitWidth = YES;
        self.lblTitle.adjustsLetterSpacingToFitWidth = YES;
        
        self.lblWager.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
