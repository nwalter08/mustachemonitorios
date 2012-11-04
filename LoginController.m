//
//  LoginController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

@synthesize Username, Password, BackgroundImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stash-background-repeating.png"]];
    self.BackgroundImage.backgroundColor = patternColor;
    self.view.backgroundColor = [UIColor colorWithRed:57.0 green:167.0 blue:201.0 alpha:1.0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginTapped:(id)sender {
    
    //The URL of JSON service
    NSString *_urlString = @"http://mustachemonitor.com/user/login";
    NSURL *_url = [NSURL URLWithString:_urlString];
    
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url];
    
    [_request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    
    [_request setAllHTTPHeaderFields:_headers];
    
    NSMutableData *body = [NSMutableData data];

    
    
    
    [body appendData:[[NSString stringWithFormat:@"screenName=myname&password=1234567"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [_request setHTTPShouldHandleCookies:YES];
    
    
    [_request setHTTPBody:body];
    
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               
                               
                               if ([data length] >0 && error == nil)
                               {
                                   NSHTTPURLResponse* httpResponse = nil;
                                   
                                   httpResponse = (NSHTTPURLResponse *)response;
                                   int statusCode = [httpResponse statusCode];
                                   NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
                                   NSLog(@"HTTP Status code: %d", statusCode);
                                   
                                   
                                   
                                   
                                   NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   //NSLog(@"%@",result);
                                   
                                   NSArray *_resultsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                   
                                   if (statusCode == 200)
                                   {
                                       [self performSegueWithIdentifier:@"SegueFromLoginToMain" sender:self];
                                   }
                                   
                                   
                               }
                               else if ([data length] == 0 && error == nil)
                               {
                                   NSLog(@"Nothing was downloaded.");
                               }
                               else if (error != nil){
                                   NSLog(@"Error = %@", error);
                               }
                               
                           }];

}
@end
