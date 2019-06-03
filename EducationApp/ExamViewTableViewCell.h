//
//  ExamViewTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 15/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *seperateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CalenderImage;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UILabel *examid;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *examTitleLabel;

@end
