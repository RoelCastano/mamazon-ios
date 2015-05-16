//
//  AppDelegate.h
//  Mamazon
//
//  Created by Roel Castano on 5/12/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MZUser *currentUser;

@end

