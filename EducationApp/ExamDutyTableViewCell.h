//
//  ExamDutyTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamDutyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UILabel *examName;
@property (weak, nonatomic) IBOutlet UILabel *classSection;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end
