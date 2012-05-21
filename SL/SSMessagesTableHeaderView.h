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
    
    IBOutlet UIImageView *messageImageView;
    
    UIButton *callButton;
    UIButton *facetimeButton;
    UIButton *addContactButton;
    
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) IBOutlet UIImageView *messageImageView;

@property (nonatomic, retain) UIButton *callButton;
@property (nonatomic, retain) UIButton *facetimeButton;
@property (nonatomic, retain) UIButton *addContactButton;

@end
