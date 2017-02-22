//
//  GetWeather.h
//  Background Weather
//
//  Created by M Newill on 08/10/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GetWeather : NSObject

@property (strong, nonatomic) NSString *currentLocation;
@property (strong, nonatomic) NSString *currentTemperature;

- (void)getWeatherAtCurrentLocation:(CLLocationCoordinate2D)coordinate;

@end
