//
//  EntryCell.h
//  Background Weather
//
//  Created by Hardik on 19/10/16.
//  Copyright © 2016 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryCell : UITableViewCell
{
    NSString *reuseID;

}
@property (nonatomic, strong) UILabel *recordNumber;
@property (nonatomic, strong) UILabel *cordinates;
@property (nonatomic, strong) UILabel *distanceFromLast;
@property (nonatomic, strong) UILabel *durationFromLast;
@property (nonatomic, strong) UILabel *timeExact;

@end
