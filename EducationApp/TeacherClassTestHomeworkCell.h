//
//  TeacherClassTestHomeworkCell.h
//  EducationApp
//
//  Created by HappySanz on 06/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClassTestHomeworkCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *subjectName;
@property (strong, nonatomic) IBOutlet UILabel *dateLabelClasstest;
@property (strong, nonatomic) IBOutlet UILabel *homeworkLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeworkdateLabel;
@property (strong, nonatomic) IBOutlet UILabel *classtestLabel;
@property (strong, nonatomic) IBOutlet UILabel *classTestDateLabel;

@end
