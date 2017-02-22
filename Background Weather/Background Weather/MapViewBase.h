//
//  MapViewBase.h
//  Background Weather
//
//  Created by Hardik on 19/10/16.
//  Copyright © 2016 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewBase : UIView <MKMapViewDelegate>

{
    CLLocationCoordinate2D arrayCordinates[500];

    MKPolyline *line;
    MKPolylineView *lineView;
    MKMapView *mapView;
}
-(void)updateMap;

-(void)setUpMapView;
@end
