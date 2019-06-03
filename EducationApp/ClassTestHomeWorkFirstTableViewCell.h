//
//  ClassTestHomeWorkFirstTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTestHomeWorkFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *homeWorkType;
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;


@end
