//
//  TeacherAttendanceTableCell.h
//  EducationApp
//
//  Created by HappySanz on 23/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAttendanceTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *statusColor;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *serialNumber;
@property (strong, nonatomic) IBOutlet UILabel *studentName;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLeaveLabel;

@end
