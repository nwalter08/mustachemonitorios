//
//  TabController.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/3/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabController : UITabBarController

- (void)makeStacheRefresh;
-(void)setId:(NSString*)theId;

@property (strong, nonatomic) NSString* AnimationId;

@end
