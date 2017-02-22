//
//  ViewController.h
//  Background Weather
//
//  Created by M Newill on 08/10/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewBase.h"

@interface ViewController : UIViewController <UITableViewDataSource>
{
 
    UIButton *buttonLocations;
    UIButton *buttonBackground;
    
    
    int selectedItem;
    UILabel *status;
    
    MapViewBase *view;
    UITableView *keyTableView;
}

@end
