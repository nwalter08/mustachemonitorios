//
//  ShareAnimationController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/3/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "ShareAnimationController.h"
#import "TabController.h"

@interface ShareAnimationController ()

@end

@implementation ShareAnimationController

@synthesize AnimationId = _AnimationId;
@synthesize GifWebView = _GifWebView;

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
    [self reloadWeb];
    
    UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stash-background-repeating.png"]];
    self.BackgroundImage.backgroundColor = patternColor;
    }

-(void)reloadWeb
{
    //self.GifWebView.scrollView.scrollEnabled = NO;
    self.GifWebView.scrollView.bounces = NO;
    
    if (self.AnimationId == nil)
    {
        self.AnimationId = [(TabController*)self.tabBarController AnimationId];
        if (self.AnimationId == nil)
        {
            self.AnimationId = @"http://mustachemonitor.com/";
        }
    }
    
    NSString *urlAddress = self.AnimationId;
    
    NSLog(@"URL IS:%@",urlAddress);
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.GifWebView loadRequest:requestObj];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
