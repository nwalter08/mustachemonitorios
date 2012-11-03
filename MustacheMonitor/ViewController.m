
//
//  ViewController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/1/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "ViewController.h"
#import "GKImagePicker.h"
#import "StacheCollectionViewController.h"
#import "TabController.h"

@interface ViewController ()



@end



@implementation ViewController

@synthesize imageView, choosePhotoBtn, takePhotoBtn, ImageSpinner;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.ImageSpinner setHidden:YES];
    
}

-(IBAction) getPhoto:(id) sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
    
    
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //UIImageView *cameraOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_overlay.png"]];
        
        UIImageView *cameraOverlayView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        
        cameraOverlayView.center = picker.view.center;
        cameraOverlayView.backgroundColor = [UIColor blueColor];
        picker.cameraOverlayView = cameraOverlayView;
	
    
    
    
	[self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)secondUploader:(id)sender
{
    //Place spinner over UIImage
    
    [self.ImageSpinner setHidden:NO];
    [self.ImageSpinner startAnimating];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //Set Params
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPShouldHandleCookies:YES];

    
    //Create boundary, it can be anything
    NSString *boundary = @"------WebKitFormBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:11];
    [parameters setValue:@"Value" forKey:@"Server_required_param"];
    
    // add params (all params are strings)
    for (NSString *param in parameters) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"displayImage";
    
    //UIImage *scaledImage = [UIImage imageWithCGImage:[self.imageView.image CGImage] scale:4.0 orientation:UIImageOrientationUp];
    
    CGSize newSize = CGSizeMake(220,220);
    
    UIGraphicsBeginImageContext( newSize );
    [self.imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSData *imageData = UIImageJPEGRepresentation(newImage, .5);
     

    
    
    NSLog(@"kB:%f",imageData.length/1000.0);
    NSLog(@"%@",[NSValue valueWithCGSize:newImage.size]);
    
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    // set URL
    NSString *urlString = @"http://mustachemonitor.com/upload";
    [request setURL:[NSURL URLWithString:urlString]];
    //[request setURL:[NSURL URLWithString:[[URLLibrary sharedInstance] getCreateFeedURL]]];

    
    
    //Here is where you would add any GUI indicators such as a load view to let the user know you are working.
    
    
    //Start your connection and handle any UI components you need to such as removing a loading view after the transaction is complete.
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //Here is where you put your code to remove a loading view or something.
                               NSLog(@"HERE");
                               
                               if ([data length] >0 && error == nil)
                               {
                                   NSHTTPURLResponse* httpResponse = nil;
                                
                                   httpResponse = (NSHTTPURLResponse *)response;
                                   int statusCode = [httpResponse statusCode];
                                   NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
                                   NSLog(@"HTTP Status code: %d", statusCode);

                                   
                                   NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   //NSLog(@"%@",result);
                                   
                                   
                                   if (statusCode == 200)
                                   {
                                       //Change to My Pics tab
                                       
                                       // Get views. controllerIndex is passed in as the controller we want to go to.
                                       UIView * fromView = self.tabBarController.selectedViewController.view;
                                       UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:1] view];
                                       
                                       // Transition using a page curl.
                                       [UIView transitionFromView:fromView
                                                           toView:toView
                                                         duration:0.5
                                                          options:(1 > self.tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
                                                       completion:^(BOOL finished) {
                                                           if (finished) {
                                                               self.tabBarController.selectedIndex = 1;
                                                               [(TabController*)self.tabBarController makeStacheRefresh];
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







- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	[picker dismissViewControllerAnimated:YES completion:nil];
    
	
    UIImage *original = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImage *ret = nil;
    
    // This calculates the crop area.
    
    float originalWidth  = original.size.width;
    float originalHeight = original.size.height;
    
    float edge = fminf(originalWidth, originalHeight);
    
    float posX = (originalWidth   - edge) / 2.0f;
    float posY = (originalHeight  - edge) / 2.0f;
    
    
    CGRect cropSquare = CGRectMake(posY, 0,
                                   edge, edge);
    
    
    // This performs the image cropping.
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([original CGImage], cropSquare);
    
    ret = [UIImage imageWithCGImage:imageRef
                              scale:original.scale
                        orientation:original.imageOrientation];
    
    CGImageRelease(imageRef);
    
    NSLog(@"NEW SIZE:%@",[NSValue valueWithCGSize:ret.size]);
    
    self.imageView.image = ret;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
