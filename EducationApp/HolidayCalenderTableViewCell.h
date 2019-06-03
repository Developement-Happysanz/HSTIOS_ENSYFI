//
//  HolidayCalenderTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HolidayCalenderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leaveTitle;
@property (weak, nonatomic) IBOutlet UILabel *leaveReson;
@property (weak, nonatomic) IBOutlet UILabel *LeaveDate;
@property (weak, nonatomic) IBOutlet UIImageView *leaveImage;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end
