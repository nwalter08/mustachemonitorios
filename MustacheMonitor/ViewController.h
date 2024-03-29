//
//  ViewController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/1/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate,
UINavigationControllerDelegate> {
    UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
}

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ImageSpinner;
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundImage;

-(IBAction) getPhoto:(id) sender;
- (IBAction)uploadImg:(id)sender;
-(UIImage*)imageCrop:(UIImage*)original;

@end
