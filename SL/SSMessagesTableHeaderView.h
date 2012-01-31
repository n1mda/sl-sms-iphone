//
//  SSMessagesTableHeaderView.h
//  SL
//
//  Created by Axel Möller on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSMessagesTableHeaderView : UIViewController {
    id delegate;
}

@property (nonatomic, retain) id delegate;

@end
