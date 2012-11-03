//
//  SignUpController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController
- (IBAction)SignUpTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *FirstName;
@property (strong, nonatomic) IBOutlet UITextField *LastName;
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UITextField *ReenterPassword;
- (IBAction)BackTapped:(id)sender;


@end
