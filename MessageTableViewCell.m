//
//  MessageTableViewCell.m
//  SL
//
//  Created by Axel Möller on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(28, 2, 320, 20);
    
    self.detailTextLabel.frame = CGRectMake(28, 20, 260, 20);
    
    self.detailTextLabel.numberOfLines = 2;
}

@end
