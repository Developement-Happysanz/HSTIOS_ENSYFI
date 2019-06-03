//
//  AdminTeacherTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTeacherTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *subjectName;

@property (strong, nonatomic) IBOutlet UILabel *teacherName;
@property (strong, nonatomic) IBOutlet UILabel *rollNumber;

@end
