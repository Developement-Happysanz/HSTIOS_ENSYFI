//
//  TeacherAttendanceViewCell.h
//  EducationApp
//
//  Created by HappySanz on 03/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAttendanceViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rollNumber;
@property (strong, nonatomic) IBOutlet UILabel *studeNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *attendanceTxtfld;

@end
