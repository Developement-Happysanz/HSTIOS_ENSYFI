//
//  NewTimeTableTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 25/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTimeTableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *breakLabel;
@property (weak, nonatomic) IBOutlet UILabel *statPeriodLabel;
@property (weak, nonatomic) IBOutlet UIView *lineTwo;
@property (weak, nonatomic) IBOutlet UIView *lineOne;
@property (weak, nonatomic) IBOutlet UIImageView *calenderImageview;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *period;
@property (weak, nonatomic) IBOutlet UILabel *staffName;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
