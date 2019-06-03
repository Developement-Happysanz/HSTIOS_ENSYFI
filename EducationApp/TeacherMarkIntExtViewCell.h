//
//  TeacherMarkIntExtViewCell.h
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherMarkIntExtViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rollNum;
@property (strong, nonatomic) IBOutlet UILabel *studentName;
@property (strong, nonatomic) IBOutlet UITextField *internalMark;
@property (strong, nonatomic) IBOutlet UITextField *externalMark;

@end
