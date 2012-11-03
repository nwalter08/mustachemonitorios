//
//  LoginController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UITextField *Password;
- (IBAction)LoginTapped:(id)sender;

@end
