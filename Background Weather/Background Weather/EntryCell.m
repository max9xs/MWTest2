//
//  EntryCell.m
//  Background Weather
//
//  Created by Hardik on 19/10/16.
//  Copyright © 2016 Mobient. All rights reserved.
//

#import "EntryCell.h"

@implementation EntryCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        
        
        
//        @property (nonatomic, strong) UILabel *recordNumber;
//        @property (nonatomic, strong) UILabel *cordinates;
//        @property (nonatomic, strong) UILabel *distanceFromLast;
//        @property (nonatomic, strong) UILabel *durationFromLast;
//        @property (nonatomic, strong) UILabel *timeExact;

        
        self.recordNumber = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
        [self.recordNumber setTextColor:[UIColor blackColor]];
        [self.recordNumber setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0f]];
        [self.contentView addSubview:self.recordNumber];
        self.recordNumber.textAlignment=NSTextAlignmentCenter;
        self.recordNumber.backgroundColor=[UIColor redColor];
        self.recordNumber.textColor=[UIColor whiteColor];
        self.recordNumber.adjustsFontSizeToFitWidth=YES;
        
        
        self.cordinates = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 200, 20)];
        [self.cordinates setTextColor:[UIColor blackColor]];
        [self.cordinates setFont:[UIFont fontWithName:@"Avenir-Light" size:14.0]];
        [self.contentView addSubview:self.cordinates];
        
        
        
        self.distanceFromLast = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 100, 20)];
        [self.distanceFromLast setTextColor:[UIColor darkGrayColor]];
        [self.distanceFromLast setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0f]];
        [self.contentView addSubview:self.distanceFromLast];
        
        self.durationFromLast = [[UILabel alloc] initWithFrame:CGRectMake(105, 50, 50, 20)];
        [self.durationFromLast setTextColor:[UIColor darkGrayColor]];
        [self.durationFromLast setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0f]];
        [self.contentView addSubview:self.durationFromLast];
        
        self.timeExact = [[UILabel alloc] initWithFrame:CGRectMake(320-150, 5, 145, 40)];
        [self.timeExact setTextColor:[UIColor blackColor]];
        [self.timeExact setFont:[UIFont fontWithName:@"Avenir-Black" size:12.0f]];
        [self.contentView addSubview:self.timeExact];
        self.timeExact.numberOfLines=2;
        

        self.timeExact.textAlignment=NSTextAlignmentRight;
        
        
        
        
        
    }
    return self;
}


@end
