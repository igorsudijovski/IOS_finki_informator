//
//  BIDAppDelegate.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapController.h"
#import "Twitter.h"

@interface BIDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *rootController;
@property (strong, nonatomic) IBOutlet UINavigationController *navStudiiController;
@property (strong, nonatomic) IBOutlet UINavigationController *navOglasnaController;
@property (strong, nonatomic) IBOutlet UINavigationController *navNovostiController;
@property (strong, nonatomic) IBOutlet MapController *mapController;
@property (strong, nonatomic) IBOutlet Twitter *twitterController;

-(UIImage *) getImage:(NSString *) path;

@end
