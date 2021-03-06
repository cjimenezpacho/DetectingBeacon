//
//  AppDelegate.m
//  DetectingBeacon
//
//  Created by Carlos Jiménez Pacho on 15/1/16.
//  Copyright © 2016 Carlos Jiménez Pacho. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@import CoreLocation;

@interface AppDelegate ()<CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    ViewController *vc = [[ViewController alloc]init];
    self.window.rootViewController = vc;

    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil]];

    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"Register %lu",(unsigned long)notificationSettings.types);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"locationManager didEnterRegion on App Delegate");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Enjoy your coffe!";
        notification.soundName = @"Default";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"locationManager didExitRegion on App Delegate");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Leaving coffe zone. May the force be with you!";
        notification.soundName = @"Default";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}


@end
