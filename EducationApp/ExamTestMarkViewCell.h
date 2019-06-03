//
//  ExamTestMarkViewCell.h
//  EducationApp
//
//  Created by HappySanz on 21/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamTestMarkViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *markLabel;
@property (strong, nonatomic) IBOutlet UILabel *gradeLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleSubjectNameLabel;

@end
