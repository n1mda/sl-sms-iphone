//
//  MessageTableViewCell.h
//  SL
//
//  Created by Axel Möller on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell {
    UILabel *dateLabel;
}

@property (nonatomic, retain) UILabel *dateLabel;

@end
