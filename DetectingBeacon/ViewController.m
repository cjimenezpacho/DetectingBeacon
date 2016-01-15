//
//  ViewController.m
//  DetectingBeacon
//
//  Created by Carlos Jiménez Pacho on 15/1/16.
//  Copyright © 2016 Carlos Jiménez Pacho. All rights reserved.
//

#import "ViewController.h"

NSString *nameIdenfier = @"coffe_place";

@import CoreLocation;

@interface ViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
}

@end

@implementation ViewController

- (instancetype) init{
    self = [super initWithNibName:@"ViewController" bundle:nil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }

}

- (void)startMonitoringARegion{

    [_locationManager startMonitoringForRegion:[self beaconRegion]];
    
}


- (void) stopMonitoringARegion{
    [_locationManager stopMonitoringForRegion:[self beaconRegion]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CLBeaconRegion*) beaconRegion{
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"5dc33487f02e477d40580117c5532d50"];
    CLBeaconMajorValue major = 0x4fac;
    CLBeaconMinorValue minor = 0xa879;

    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                           major:major
                                                                           minor:minor
                                                                      identifier:nameIdenfier];

    return beaconRegion;
}

- (IBAction)startMonitoring:(id)sender {
    ((UIButton*)sender).selected = !((UIButton*)sender).selected;
    if(((UIButton*)sender).selected)
        [self startMonitoringARegion];
    else
        [self stopMonitoringARegion];
    
}


#pragma mark - location delegate

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Failed monitoring region: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region{
    
    NSLog(@"locationManager didRangeBeacons %@ on Region %@",beacons,region);
}

@end
