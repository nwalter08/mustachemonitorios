//
//  TabController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/3/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "TabController.h"
#import "StacheCollectionViewController.h"

@interface TabController ()

@end

@implementation TabController

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
}

- (void)makeStacheRefresh
{
    NSArray *myControllers = [self viewControllers];
    for (UIViewController *tempCon in myControllers)
    {
        if ([tempCon isKindOfClass:[StacheCollectionViewController class]])
        {
            NSLog(@"Got StacheCollectionViewController");
            [(StacheCollectionViewController*)tempCon asyncCallForStaches];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
