//
//  StachePic.h
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StachePic : NSObject

@property (nonatomic, strong) NSString *id;
@property BOOL imgLoaded;
@property BOOL send;
@property (nonatomic, strong) UIImage *actualImage;

@end
