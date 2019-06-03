//
//  TeacherExamDetailViewCell.h
//  EducationApp
//
//  Created by HappySanz on 11/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherExamDetailViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;

@end
