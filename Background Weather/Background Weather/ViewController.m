//
//  ViewController.m
//  Background Weather
//
//  Created by M Newill on 08/10/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "EntryCell.h"

@interface ViewController ()
@end

@implementation ViewController

BOOL weatherCalled = 0;
NSUserDefaults *standardDefaults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    buttonLocations=[[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/2, 30)];
    
    buttonBackground=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 20, self.view.frame.size.width/2, 30)];
    
    status=[[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 15)];
    status.text=@"SHOWING : LOCATIONS";
    [self.view addSubview:status];
    status.textAlignment=NSTextAlignmentCenter;
    status.font=[UIFont fontWithName:@"Avenir-Black" size:10];
    
    
    [buttonLocations setTitle:@"Locations(0)" forState:UIControlStateNormal];
    [buttonBackground setTitle:@"Fetch(0)" forState:UIControlStateNormal];
    
    [self.view addSubview:buttonBackground];
    [self.view addSubview:buttonLocations];
    
    [buttonLocations setBackgroundColor:[UIColor lightGrayColor]];
    [buttonBackground setBackgroundColor:[UIColor grayColor]];
    
    [buttonLocations setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonBackground setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [buttonLocations addTarget:self action:@selector(showLocations) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonBackground addTarget:self action:@selector(showFetch) forControlEvents:UIControlEventTouchUpInside];
    
    
    selectedItem=0;
    
    
    keyTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    [self.view addSubview:keyTableView];
    keyTableView.dataSource=self;
    keyTableView.rowHeight=80;
    
    
       
    
    
    
    

    [self updateTableFrequently];
    [self imageConverter];

    
 /*    view=[[MapViewBase alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    [view setUpMapView];
   */
    
}
-(void)imageConverter
{
    NSArray *array=[NSArray arrayWithObjects:
                    @"ZarzuelaSeleccion-copaycuchillo-580x580.jpg",
                    @"abracadabra-2013.png",
                    @"calderona640.jpg",
                    @"castrobrey-2-640 2.jpg",
                    @"castrobrey-2-640.jpg",
                    @"divina-outside640.jpg",
                    @"img_3437_1_.jpg",
                    @"lardepaula-street290.jpg",
                    @"muruve-crianza-2011-toro.jpg",
                    @"ramon-vanessa.jpg",
                    @"vina-calderona-rosado-2014.jpg",
                    @"vj_2010_copia.jpg",
                    @"vz-s-garnacha-b-e1439982847667.jpg",
                    @"xanum-vinae-rioja-doca-spain-10641974.jpg",
                     nil];
    
    
    NSMutableArray *arraMax=[[NSMutableArray alloc] init];
    
    for(int i=0;i<259;i++)
    {
        NSString *image=[NSString stringWithFormat:@"frame_%d.png",i+1];
        
        [arraMax addObject:image];
    }

    array=[NSArray arrayWithArray:arraMax];
    
    for(int i=0;i<[array count];i++)
    {
    
        NSString *string=[array objectAtIndex:i];
        
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 800, 600)];
    [self.view addSubview:imageView];
    imageView.image=[UIImage imageNamed:string];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.clipsToBounds=YES;
    
    UIImage *image=[self pb_takeSnapshot:imageView];
    
    
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",string]];
    
        NSLog(@"%@",imagePath);
    [UIImageJPEGRepresentation(image, 1) writeToFile:imagePath atomically:YES];
    }

    
    
}
- (UIImage *)pb_takeSnapshot:(UIImageView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale/2);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)showLocations
{
    status.text=@"SHOWING : LOCATIONS";
    selectedItem=0;
    [keyTableView reloadData];
}
-(void)showFetch
{
    status.text=@"SHOWING : FETCH";
    selectedItem=1;

    [keyTableView reloadData];
}

-(void)updateTableFrequently
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    [keyTableView reloadData];
    
    [self performSelector:@selector(updateTableFrequently) withObject:nil afterDelay:1.0];
    
    [buttonLocations setTitle:[NSString stringWithFormat:@"Locations(%d)",(int)delegate.arrayList.count] forState:UIControlStateNormal];
    
    [buttonBackground setTitle:[NSString stringWithFormat:@"Fetch(%d)",(int)delegate.backgroundFeatchList.count] forState:UIControlStateNormal];

//    [view updateMap];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray *array;
    
    if(selectedItem==0)
    {
    array=delegate.arrayList;
    }
    else
    {
        array=delegate.backgroundFeatchList;
    }
    
   return array.count;
}
-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    EntryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[EntryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    NSArray *array;
    
    if(selectedItem==0)
    {
        array=delegate.arrayList;
    }
    else
    {
        array=delegate.backgroundFeatchList;
    }
    
    NSDictionary *dict=[array objectAtIndex:indexPath.row];
    CLLocationDistance distance=0;
    
    NSString *timeExact=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss z";
    NSDate *dateExact = [dateFormatter dateFromString:timeExact];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    dateFormatter.dateFormat = @"hh:mm:ss a\ndd,MMM";
    timeExact = [dateFormatter stringFromDate:dateExact];

    
    ////////
    
    NSString *calculatedTime=@"0";
    
    if(indexPath.row-1>0)
    {
        NSDictionary *dictOld=[array objectAtIndex:indexPath.row-1];
        
        NSString *timeOld=[NSString stringWithFormat:@"%@",[dictOld valueForKey:@"time"]];
        NSString *timeNew=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
        
        
        float c1=[[dict valueForKey:@"Lat"] floatValue];
        float c2=[[dict valueForKey:@"Long"] floatValue];
        
        float l1=[[dictOld valueForKey:@"Lat"] floatValue];
        float l2=[[dictOld valueForKey:@"Long"] floatValue];
        
       // NSLog(@"%f,%f-%f,%f",c1,c2,l1,l2);
        
        
        CLLocation *locA = [[CLLocation alloc] initWithLatitude:c1 longitude:c2];
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:l1 longitude:l2];
         distance = [locA distanceFromLocation:locB];
        
        

        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss z";
        NSDate *dateOld = [dateFormatter dateFromString:timeOld];
        NSDate *dateNew = [dateFormatter dateFromString:timeNew];
        
        
        
        
        calculatedTime=[NSString stringWithFormat:@"+%1.0f s",[dateNew timeIntervalSinceDate:dateOld]];


        
    }
    else
    {
        calculatedTime=@"0";
        
        if(selectedItem==1 && indexPath.row==0)
        {
            NSDictionary *locationFirstTime=[delegate.arrayList objectAtIndex:0];
            NSString *timeFirstTime=[NSString stringWithFormat:@"%@",[locationFirstTime valueForKey:@"time"]];
            
            NSDictionary *fetchRecordTime=[array objectAtIndex:indexPath.row];
            NSString *timeFetch=[NSString stringWithFormat:@"%@",[fetchRecordTime valueForKey:@"time"]];
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss z";
            NSDate *dateOld = [dateFormatter dateFromString:timeFirstTime];
            NSDate *dateNew = [dateFormatter dateFromString:timeFetch];
            
            calculatedTime=[NSString stringWithFormat:@"+%1.0fs",[dateNew timeIntervalSinceDate:dateOld]];


            
        }
        
    }
    
    
    
    
    // Get Current Location from NSUserDefaults
    CLLocationCoordinate2D currentLocation;
    currentLocation.latitude = [[dict valueForKey:@"Lat"] floatValue];
    currentLocation.longitude = [[dict valueForKey:@"Long"] floatValue];

    
    
    cell.cordinates.text=[NSString stringWithFormat:@"%f,%f",currentLocation.latitude,currentLocation.longitude];

    cell.recordNumber.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.durationFromLast.text=calculatedTime;
    cell.distanceFromLast.text=[NSString stringWithFormat:@"+%1.1fm",distance];
    cell.timeExact.text=timeExact;

    
    
//    cell.detailTextLabel.text=calculatedTime;
    
    
    
    return cell;
}



- (IBAction)refreshTemp:(UIButton *)sender {
//    [self.locationManager startUpdatingLocation];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
