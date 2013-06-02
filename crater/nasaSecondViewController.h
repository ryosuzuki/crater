//
//  nasaFirstViewController.h
//  crater
//
//  Created by Ryo Suzuki on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "SBJson.h"


@interface nasaSecondViewController : UIViewController <UIScrollViewDelegate, UITabBarControllerDelegate>
{
    
    NSNumber *sphere_id;
    
    UIScrollView *scrollView;
    
    NSMutableArray *cratersArray;
    NSMutableDictionary *cratersDict;
    
    NSMutableArray *IDs;
    NSMutableArray *imageURL;
    
    NSMutableArray *imageList;
    NSMutableArray *imageViewList;
    
    CGRect imageFrame;
    
    CALayer *layer;
    
    UIView *modalView;
    
    UITapGestureRecognizer *gesture;
    CGRect currentFrame;
    
    
    UIActivityIndicatorView *indicator;
    
    NSURLConnection *connection; 
	NSMutableData *data;
    
}

@property (nonatomic, retain) NSNumber *sphere_id;

@end
