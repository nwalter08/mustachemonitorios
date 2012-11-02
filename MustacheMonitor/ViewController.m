//
//  ViewController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/1/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end



@implementation ViewController

@synthesize imageView, choosePhotoBtn, takePhotoBtn;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
    
    //TODO Fix this if statement logic
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //UIImageView *cameraOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_overlay.png"]];
        
        UIImageView *cameraOverlayView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        
        cameraOverlayView.center = picker.view.center;
        cameraOverlayView.backgroundColor = [UIColor blueColor];
        picker.cameraOverlayView = cameraOverlayView;
	}
    
    
    
	[self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)secondUploader:(id)sender
{
    [self performSegueWithIdentifier:@"SugueToImagePick" sender:self];
    
    /*
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //Set Params
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
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
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, .5);

    
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
                                   NSLog(@"%@",result);
                                   
                                   
                               }
                               else if ([data length] == 0 && error == nil)
                               {
                                   NSLog(@"Nothing was downloaded.");
                               }
                               else if (error != nil){
                                   NSLog(@"Error = %@", error);
                               }
                           }];
     */
    
}

- (IBAction)uploadImg:(id)sender {
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, .5);    //change Image to NSData
    
    if (imageData != nil)
    {
        NSString *filenames = [NSString stringWithFormat:@"TextLabel"];      //set name here
        NSLog(@"%@", filenames);
        NSString *urlString = @"http://mustachemonitor.com/upload";
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"filenames\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[filenames dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        // now lets make the connection to the web
        NSURLResponse *response = nil;
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"RESULT: %@",returnString);
        NSLog(@"finish");
        
        NSHTTPURLResponse * httpResponse = nil;
        
        httpResponse = (NSHTTPURLResponse *)response;
        int statusCode = [httpResponse statusCode];
        NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
        NSLog(@"HTTP Status code: %d", statusCode);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
