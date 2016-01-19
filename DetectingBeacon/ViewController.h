//
//  ViewController.h
//  DetectingBeacon
//
//  Created by Carlos Jiménez Pacho on 15/1/16.
//  Copyright © 2016 Carlos Jiménez Pacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    __weak IBOutlet UITextView *_lblLogMonitoring;
    __weak IBOutlet UILabel *_lblCurrentlyMonitoring;
    __weak IBOutlet UIButton *_btnStartStopMonitoring;
}

- (IBAction)startMonitoring:(id)sender;

@end

