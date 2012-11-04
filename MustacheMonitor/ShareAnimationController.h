//
//  ShareAnimationController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/3/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareAnimationController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *GifWebView;
@property (strong, nonatomic) NSString* AnimationId;
-(void)reloadWeb;
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundImage;

@end
