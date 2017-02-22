//
//  AppDelegate.h
//  Background Weather
//
//  Created by M Newill on 08/10/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{

}
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) UIWindow *window;
@property NSMutableArray *arrayList;
@property NSMutableArray *backgroundFeatchList;

-(void)addEntry:(CLLocationCoordinate2D)cordinate;

@end
