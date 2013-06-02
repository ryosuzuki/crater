//
//  nasaAppDelegate.h
//  crater
//
//  Created by Ryo Suzuki on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nasaAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    id tabSelectedView;

}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
