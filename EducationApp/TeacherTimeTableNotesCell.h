//
//  TeacherTimeTableNotesCell.h
//  EducationApp
//
//  Created by HappySanz on 13/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherTimeTableNotesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *className;
@property (strong, nonatomic) IBOutlet UILabel *subjectName;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIView *cellView;

@end
