//
//  ClassTeachetAttendenceTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 19/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTeachetAttendenceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *sentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sentImage;
@property (weak, nonatomic) IBOutlet UILabel *absentLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentlabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStudentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgDate;

@end
