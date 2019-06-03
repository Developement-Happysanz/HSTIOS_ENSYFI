//
//  ExamMarkViewCell.h
//  EducationApp
//
//  Created by HappySanz on 25/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamMarkViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *totalMark;
@property (strong, nonatomic) IBOutlet UILabel *totalGrade;
@property (strong, nonatomic) IBOutlet UILabel *extMark;
@property (strong, nonatomic) IBOutlet UILabel *extGrade;
@property (strong, nonatomic) IBOutlet UILabel *intMark;
@property (strong, nonatomic) IBOutlet UILabel *intGrade;
@property (weak, nonatomic) IBOutlet UILabel *marksLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sub_stu_Name;

@end
