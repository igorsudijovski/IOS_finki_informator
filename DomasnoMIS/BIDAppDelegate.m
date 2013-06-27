//
//  BIDAppDelegate.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "BIDAppDelegate.h"
#import "StudiskiProgramiFirstController.h"
#import "MapController.h"
#import "Twitter.h"
#import "VestiController.h"
#import "OglasnaController.h"

@implementation BIDAppDelegate

@synthesize window = _window;
@synthesize rootController;
@synthesize navStudiiController;
@synthesize navNovostiController;
@synthesize navOglasnaController;
@synthesize mapController;
@synthesize twitterController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    UITabBarItem *itemnovosti = [[UITabBarItem alloc] initWithTitle:@"Новости" image:[self getImage:@"finkilogo"] tag:1];
    UITabBarItem *itemoglasna = [[UITabBarItem alloc] initWithTitle:@"Огласна" image:[self getImage:@"finkilogo"] tag:2];
    UITabBarItem *itemstudii = [[UITabBarItem alloc] initWithTitle:@"Студии" image:[self getImage:@"finkilogo"] tag:3];
    UITabBarItem *itemmap = [[UITabBarItem alloc] initWithTitle:@"Мапа" image:[self getImage:@"map"] tag:4];
    UITabBarItem *itemtwitter = [[UITabBarItem alloc] initWithTitle:@"Twiiter" image:[self getImage:@"twitter"] tag:5];
    rootController = [[UITabBarController alloc] init];
    navStudiiController = [[UINavigationController alloc] init];
    navNovostiController = [[UINavigationController alloc] init];
    navOglasnaController = [[UINavigationController alloc] init];
    twitterController = [[Twitter alloc] init];
    twitterController.title = @"Twiiter";
    mapController = [[MapController alloc] init];
    mapController.title = @"Мапа";
    StudiskiProgramiFirstController *studiskiController = [[StudiskiProgramiFirstController alloc] init];
    studiskiController.title = @"Студиски програми";
    VestiController *vestiController = [[VestiController alloc] init];
    vestiController.title = @"Новости";
    OglasnaController *oglasna = [[OglasnaController alloc] init];
    oglasna.title = @"Огласна табла";
    [navOglasnaController pushViewController:oglasna animated:NO];
    [navNovostiController pushViewController:vestiController animated:NO];
    [navStudiiController pushViewController:studiskiController animated:NO];
    navNovostiController.tabBarItem = itemnovosti;
    navOglasnaController.tabBarItem = itemoglasna;
    navStudiiController.tabBarItem = itemstudii;
    mapController.tabBarItem = itemmap;
    twitterController.tabBarItem = itemtwitter;
    rootController.viewControllers = [NSArray arrayWithObjects:navNovostiController, navOglasnaController, navStudiiController,mapController,twitterController, nil];
    
    // Override point for customization after application launch.
    self.window.rootViewController = rootController;
//    [self.window addSubview:rootController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(UIImage *) getImage:(NSString *) path{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"png"];
    NSURL *filenameAndPath = [NSURL fileURLWithPath:filePath];
    NSData *data = [NSData dataWithContentsOfURL:filenameAndPath];
    UIImage *img = [[UIImage alloc] initWithData:data];
    return img;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
