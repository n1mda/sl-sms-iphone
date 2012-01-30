//
//  SSMessagesTableHeaderDateView.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSMessagesTableHeaderDateView : UIViewController {
    IBOutlet UILabel *dateLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *dateLabel;

- (void)setLabelText:(NSString *)text;

@end
