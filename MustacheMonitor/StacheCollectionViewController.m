//
//  StacheCollectionViewController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "StacheCollectionViewController.h"
#import "StachePickCell.h"
#import "SBJson.h"
#import "StachePic.h"
#import "TabController.h"

@interface StacheCollectionViewController ()

@end

@implementation StacheCollectionViewController

@synthesize CollView = _CollView;
@synthesize StacheLoader = _StacheLoader;
@synthesize StachePics = _StachePics;


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

    self.CollView.delegate = self;
    
    self.CollView.dataSource = self;
    
    [self asyncCallForStaches];
}



-(void)asyncCallForStaches
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://mustachemonitor.com/user/images"];
    NSLog(@"%@",urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    //set headers
    
    
    //get response
    
    [request setHTTPShouldHandleCookies:YES];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if ([data length] > 0 && error == nil)
         {
             NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSHTTPURLResponse* httpResponse = nil;
             
             httpResponse = (NSHTTPURLResponse *)response;
             int statusCode = [httpResponse statusCode];
             NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
             NSLog(@"HTTP Status code: %d", statusCode);
             
             
             
             
             // Create a dictionary from the JSON string
             NSDictionary *results = [result JSONValue];
             
             NSLog(@"DA RESULTS: %@", results);
             
             NSMutableArray *mutableStachePics = [[NSMutableArray alloc] init];
             
             for (NSDictionary *topic in results)
             {
                 StachePic *tempStachePic = [[StachePic alloc] init];
                 tempStachePic.id = [NSString stringWithFormat:@"%@", [topic objectForKey:@"id"]];
                 [tempStachePic setSend:YES];
                 
                 [mutableStachePics addObject:tempStachePic];
             }
             
             
             self.stachePics = mutableStachePics;
             [self.CollView reloadData];
             [self.StacheLoader setHidden:YES];
             
             
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


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.StachePics count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    StachePickCell *cell = (StachePickCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StachePickCell" forIndexPath:indexPath];
    
    StachePic *tempStache = [self.StachePics objectAtIndex:indexPath.row];
    
    //CHECK to see if there is already an image loaded. IF so no async
    if (!tempStache.imgLoaded)
    {
        
        
        NSString *urlString = [NSString stringWithFormat:@"http://mustachemonitor.com/images/%@", tempStache.id];
        NSLog(@"%@",tempStache.id);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"GET"];
        
        //set headers
        //NSString *contentType = [NSString stringWithFormat:@"application/json"];
        //[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [request setHTTPShouldHandleCookies:YES];
        
        [NSURLConnection
         sendAsynchronousRequest:request
         queue:[NSOperationQueue mainQueue]
         completionHandler:^(NSURLResponse *response,
                             NSData *data,
                             NSError *error)
         {
             
             if ([data length] >0 && error == nil)
             {
                 NSHTTPURLResponse* httpResponse = nil;
                 
                 httpResponse = (NSHTTPURLResponse *)response;
                 int statusCode = [httpResponse statusCode];
                 NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
                 NSLog(@"HTTP Status code: %d", statusCode);
                 
                 UIImage *myTempy = [UIImage imageWithData:data];
                 
                 StachePickCell *cell = (StachePickCell *)[self.CollView cellForItemAtIndexPath:indexPath];
                 
                 // Display the newly loaded image
                 tempStache.actualImage = myTempy;
                 cell.ThumbStache.image = tempStache.actualImage;
                 
                 //cell.ThumbStache.layer.cornerRadius = 5.0;
                 //cell.ThumbStache.layer.masksToBounds = YES;
                 
                 
                 
                 [tempStache setImgLoaded:YES];
                 
                 
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
    else{
        cell.ThumbStache.image = tempStache.actualImage;
    }
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StachePickCell *cell = (StachePickCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StachePickCell" forIndexPath:indexPath];
    
    cell = (StachePickCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    StachePic *tempStache = [self.StachePics objectAtIndex:indexPath.row];
    
    UIImage *checkImg = [UIImage imageNamed:@"green-select-stash.png"];
    //If green check image
    if (cell.GreenCheckBtn.image == checkImg)
    {
        //Turn to red
        [cell.GreenCheckBtn setImage:[UIImage imageNamed:@"red-no-stash.png"]];
        tempStache.send = NO;
    }
    else{
        //Turn to green
        [cell.GreenCheckBtn setImage:checkImg];
        tempStache.send = YES;
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CreateAnimationTapped:(id)sender {
    //The URL of JSON service
    NSString *_urlString = @"http://mustachemonitor.com/user/generate";
    NSURL *_url = [NSURL URLWithString:_urlString];
    
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url];
    
    [_request setHTTPMethod:@"POST"];
    
    //NSMutableDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    
    //[_request setAllHTTPHeaderFields:_headers];
    
    [_request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSMutableString *bodyString = [NSMutableString stringWithFormat:@"{\"sequence\":["];
    
    //Loop through objects in stachePics array and add to string
    
    NSLog(@"COUNTA: %d", [self.StachePics count]);
    
    int i = 0;
    BOOL firstItem = YES;
    
    for (i = 0; i < [self.StachePics count]; i++)
    {
        StachePic *tempStachePic = [self.StachePics objectAtIndex:i];
        if(tempStachePic.send)
        {
            if (firstItem)
            {
                firstItem = NO;
            }
            else
            {
                [bodyString appendString:@","];
            }
            [bodyString appendString:@"\""];
            [bodyString appendString:tempStachePic.id];
            [bodyString appendString:@"\""];
            
        }
        
    }
    
    [bodyString appendString:@"]}"];
    
    NSLog(bodyString);
    
    [body appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
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
                                   NSLog(@"%@",result);
                                   
                                   NSDictionary *_resultsDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                   
                                   
                                   
                                   if (statusCode == 200)
                                   {
                                       NSLog(@"A-OK!!");
                                       
                                       NSLog(@"URL IEEES: %@",[_resultsDic objectForKey:@"url"]);
                                       
                                       NSString *daURL = [_resultsDic objectForKey:@"url"];
                                       
                                       UIView * fromView = self.tabBarController.selectedViewController.view;
                                       UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:2] view];
                                       
                                       [(TabController*)self.tabBarController setAnimationId:daURL];
                                       
                                       
                                       [(TabController*)self.tabBarController setId:daURL];
                                       
                                       // Transition using a page curl.
                                       [UIView transitionFromView:fromView
                                                           toView:toView
                                                         duration:0.5
                                                          options:(2 > self.tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
                                                       completion:^(BOOL finished) {
                                                           if (finished) {
                                                               self.tabBarController.selectedIndex = 2;
                                                            
                                                           }
                                                       }];
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
