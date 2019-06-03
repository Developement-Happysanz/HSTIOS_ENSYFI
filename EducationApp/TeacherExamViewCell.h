//
//  TeacherExamViewCell.h
//  EducationApp
//
//  Created by HappySanz on 10/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherExamViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *fromdate;
@property (strong, nonatomic) IBOutlet UILabel *todate;

@end
