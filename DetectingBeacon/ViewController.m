//
//  ViewController.m
//  DetectingBeacon
//
//  Created by Carlos Jiménez Pacho on 15/1/16.
//  Copyright © 2016 Carlos Jiménez Pacho. All rights reserved.
//

#import "ViewController.h"

NSString *nameIdenfier = @"coffe_place";
static int logCounter = 0;
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

    for (CLBeaconRegion *region in _locationManager.monitoredRegions) {
        _lblCurrentlyMonitoring.text = [NSString stringWithFormat:@"%@%@ ",_lblCurrentlyMonitoring.text,region.identifier];
        if([region.identifier isEqualToString:nameIdenfier]){
            //_btnStartStopMonitoring.selected = YES;
        }
    }
    
}

- (void)startMonitoringARegion{
    if([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]){
        [_locationManager startMonitoringForRegion:[self beaconRegion]];
        //[_locationManager startRangingBeaconsInRegion:[self beaconRegion]];
    }else{
        NSLog(@"Monitoring not available!");
    }
}


- (void) stopMonitoringARegion{
    [_locationManager stopMonitoringForRegion:[self beaconRegion]];
    //[_locationManager stopRangingBeaconsInRegion:[self beaconRegion]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CLBeaconRegion*) beaconRegion{
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"23A01AF0-232A-4518-9C0E-323FB773F5EF"];
    CLBeaconMajorValue major = 41060;
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:major identifier:nameIdenfier];
    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=YES;
    
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

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"locationManager didStartMonitoringForRegion region %@",region);

}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    _lblLogMonitoring.text = [NSString stringWithFormat:@"%@%@%d - locationManager didEnterRegion region %@\n",_lblLogMonitoring.text,[self todayFormatted],logCounter++,region.identifier];
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    _lblLogMonitoring.text = [NSString stringWithFormat:@"%@%@%d - locationManager didExitRegion region %@\n",_lblLogMonitoring.text,[self todayFormatted],logCounter++,region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Couldn't turn on monitoring: Location services not authorised.");
    }
}

- (NSString*)todayFormatted{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}
@end
