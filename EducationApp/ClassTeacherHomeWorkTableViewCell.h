//
//  ClassTeacherHomeWorkTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 21/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTeacherHomeWorkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *classView;
@property (weak, nonatomic) IBOutlet UILabel *homeWorkLabel;
@property (weak, nonatomic) IBOutlet UILabel *classtestLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
