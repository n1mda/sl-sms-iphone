//
//  MessageTableViewCell.m
//  SL
//
//  Created by Axel Möller on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    NSLog(@"Init cell");
    
    dateLabel = [[UILabel alloc] init];
    
    [self addSubview:dateLabel];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(28, 2, 320, 20);
    
    self.detailTextLabel.frame = CGRectMake(28, 20, 260, 20);
    
    self.detailTextLabel.numberOfLines = 2;
    
    if(UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        self.dateLabel.frame = CGRectMake(self.frame.size.width - 64, 4, 50, 20);
    else
        self.dateLabel.frame = CGRectMake(self.frame.size.width - 64, 4, 50, 20);
    
}

- (void)dealloc {
    [super dealloc];
    [dateLabel release];
}

@end
