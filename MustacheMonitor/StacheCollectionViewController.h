//
//  StacheCollectionViewController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StacheCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *CollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *StacheLoader;
@property (nonatomic, strong) NSArray *StachePics;
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundImage;
- (IBAction)CreateAnimationTapped:(id)sender;
-(void)asyncCallForStaches;



@end
