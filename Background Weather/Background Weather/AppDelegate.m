//
//  AppDelegate.m
//  Background Weather
//
//  Created by M Newill on 08/10/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//  

#import "AppDelegate.h"
#import "GetWeather.h"

@implementation AppDelegate

-(void)saveNSUserDefault:(NSArray *)array withKey:(NSString *)string
{
    NSUserDefaults *sd=[NSUserDefaults standardUserDefaults];
    [sd setObject:array forKey:string];
    [sd synchronize];
}
-(NSMutableArray *)arrayDataForKey:(NSString *)string
{
    NSUserDefaults *sd=[NSUserDefaults standardUserDefaults];

    NSArray *array=[sd objectForKey:string];
    
    if(array==nil)
    {
        array=[[NSArray alloc] init];
    }
    
    return [NSMutableArray arrayWithArray:array];
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
  /*  var types: UIUserNotificationType = UIUserNotificationType()
    types.insert(UIUserNotificationType.Alert)
    types.insert(UIUserNotificationType.Badge)
    
    let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
    
    UIApplication.sharedApplication().registerUserNotificationSettings(settings)
   */

    
   // NSArray *array=[NSArray arrayWithObjects:UIUserNotificationTypeAlert,UIUserNotificationTypeBadge,UIUserNotificationTypeSound, nil];
    
    
   // NSSet *set=[NSSet setWithObjects:UIUserNotificationTypeAlert,UIUserNotificationTypeBadge, nil];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                         | UIUserNotificationTypeBadge
                                                                                         | UIUserNotificationTypeSound) categories:nil];

    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    self.arrayList=[self arrayDataForKey:@"arrayList"];
    self.backgroundFeatchList=[self arrayDataForKey:@"backgroundFeatchList"];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    
   // self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
   // self.locationManager.distanceFilter=5;
   // self.locationManager.activityType=CLActivityTypeAutomotiveNavigation;
   // self.locationManager.pausesLocationUpdatesAutomatically=YES;
    
    
     self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
     self.locationManager.distanceFilter=kCLDistanceFilterNone;
     self.locationManager.activityType=CLActivityTypeAutomotiveNavigation;
     self.locationManager.pausesLocationUpdatesAutomatically=YES;
    self.locationManager.allowsBackgroundLocationUpdates=YES;
    [self.locationManager startUpdatingLocation];

    if(self.locationManager.location == NO){
        
        NSLog(@"Location service is not avaialble");
    }
    


    // Override point for customization after application launch.
    return YES;
}
-(void)addEntryToBackground:(CLLocationCoordinate2D)cordinate
{
    NSLog(@"Background Executed");
    
    
    
    
    
    NSDictionary *dict2=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:cordinate.latitude],@"Lat",[NSNumber numberWithFloat:cordinate.longitude],@"Long",[NSDate date],@"time", nil];
    
    [self.backgroundFeatchList addObject:dict2];
    
    
    
    
    [self saveNSUserDefault:[NSArray arrayWithArray:self.backgroundFeatchList] withKey:@"backgroundFeatchList"];
    
    
    NSLog(@"Background Refreshed : %d",[self.backgroundFeatchList count]);
}
-(void)addEntry:(CLLocationCoordinate2D)cordinate
{
    NSLog(@"New Location Added");
    
    
//    NSDictionary *dict=[self.arrayList lastObject];
//    // Get Current Location from NSUserDefaults
//    CLLocationCoordinate2D currentLocation;
//    currentLocation.latitude = [[dict valueForKey:@"Lat"] floatValue];
//    currentLocation.longitude = [[dict valueForKey:@"Long"] floatValue];
    
    
    
        NSDictionary *dict2=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:cordinate.latitude],@"Lat",[NSNumber numberWithFloat:cordinate.longitude],@"Long",[NSDate date],@"time", nil];
        
        [self.arrayList addObject:dict2];

        
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=[self.arrayList count];
    
    [self saveNSUserDefault:[NSArray arrayWithArray:self.arrayList] withKey:@"arrayList"];

    
    
    NSLog(@"Total Coordinate : %d",[self.arrayList count]);
    
   
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
     //   [self.locationManager stopMonitoringSignificantLocationChanges];
    }
    
    NSLog(@"New Location Received");
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D cord=location.coordinate;
    
    
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [delegate addEntry:cord];
    
    
    /*[self getWeather:location];
     
     

     
     
     standardDefaults = [NSUserDefaults standardUserDefaults];
     [standardDefaults setFloat:location.coordinate.latitude forKey:@"locationLatitude"];
     [standardDefaults setFloat:location.coordinate.longitude forKey:@"locationLongitude"];
     */
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error while getting core location : %@ - %d",[error localizedFailureReason],[error code]);
    if ([error code] == kCLErrorDenied) {
        //you had denied
    }
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];

    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
       // [self.locationManager stopMonitoringSignificantLocationChanges];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
   /* [self.locationManager stopMonitoringSignificantLocationChanges];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    self.locationManager.activityType=CLActivityTypeAutomotiveNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically=YES;
    self.locationManager.allowsBackgroundLocationUpdates=YES;
    [self.locationManager startMonitoringSignificantLocationChanges];
    
    //[self.locationManager stopMonitoringSignificantLocationChanges];*/

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
-(void)applicationDidEnterBackground:(UIApplication *)application
{

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
-(void)applicationWillEnterForeground:(UIApplication *)application
{
    
/*    [self.locationManager stopMonitoringSignificantLocationChanges];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    self.locationManager.activityType=CLActivityTypeAutomotiveNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically=YES;
    self.locationManager.allowsBackgroundLocationUpdates=YES;
    [self.locationManager startMonitoringSignificantLocationChanges];*/

  //  [self.locationManager startMonitoringSignificantLocationChanges];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
-(void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return true;
}

-(void)getNewCoordinates
{
//    int result = number1 + number2;
    [self.locationManager startUpdatingLocation];

    
    
}

-(void)PerformTheOperation
{
    NSLog(@"Adding Notificaiotn");
    //[self performSelectorOnMainThread:@selector(getNewLocation) withObject:nil waitUntilDone:YES];
    
    NSDictionary *dict=[self.arrayList lastObject];
    // Get Current Location from NSUserDefaults
    CLLocationCoordinate2D currentLocation;
    currentLocation.latitude = [[dict valueForKey:@"Lat"] floatValue];
    currentLocation.longitude = [[dict valueForKey:@"Long"] floatValue];
    
    // GetWeather for current location
    
    // Set up Local Notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    NSDate *now = [NSDate date];
    localNotification.fireDate = now;
    localNotification.alertBody = [NSString stringWithFormat:@"Background Featch count:%d,Total locations:%d,", self.backgroundFeatchList.count+1, self.arrayList.count];
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = [self.backgroundFeatchList count];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    [self addEntryToBackground:currentLocation];

   
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"\nFetch started");
    
    
    

    [self performSelectorInBackground:@selector(getNewCoordinates) withObject:nil];
    
   // [self PerformTheOperation];

    [self performSelector:@selector(PerformTheOperation) withObject:nil afterDelay:1.0];
    
 
    
        completionHandler(UIBackgroundFetchResultNewData);
        NSLog(@"Fetch completed");

        
        
        
    
   }

@end
