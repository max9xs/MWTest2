//
//  MapViewBase.m
//  Background Weather
//
//  Created by Hardik on 19/10/16.
//  Copyright © 2016 Mobient. All rights reserved.
//

#import "MapViewBase.h"
#import "AppDelegate.h"

@implementation MapViewBase

-(void)setUpMapView
{
    
    
    self.backgroundColor=[UIColor whiteColor];
    
    mapView = [[MKMapView alloc] initWithFrame:self.frame];
    [self addSubview:mapView];
    mapView.delegate=self;

   // self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    
    [self updateMap];
    
    

    
   

}
-(void)updateMap
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *array=delegate.arrayList;
    
    
    for(int i=0;i<array.count && i<500;i++)
    {
        NSDictionary *dict=[array objectAtIndex:i];
        CLLocationCoordinate2D currentLocation;
        currentLocation.latitude = [[dict valueForKey:@"Lat"] floatValue];
        currentLocation.longitude = [[dict valueForKey:@"Long"] floatValue];
        arrayCordinates[i]=currentLocation;
    }
    
    [mapView removeAnnotations:mapView.annotations];
    [mapView removeOverlays:mapView.overlays];
    
    line = [MKPolyline polylineWithCoordinates:arrayCordinates count:array.count];
    [mapView setVisibleMapRect:[line boundingMapRect]]; //If you want the route to be visible
    [mapView addOverlay:line];
    
    
    for(int i=0;i<array.count;i++)
    {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = arrayCordinates[i];
        point.subtitle = @"I'm here!!!";
        [mapView addAnnotation:point];
        
    }

    
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor colorWithRed:204/255. green:45/255. blue:70/255. alpha:1.0];
    polylineView.lineWidth = 1;
    
    return polylineView;
}



@end
