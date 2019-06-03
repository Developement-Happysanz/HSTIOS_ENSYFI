//
//  AdminExamTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminExamTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *sepratorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *calenderImg;
@property (strong, nonatomic) IBOutlet UILabel *examId;
@property (strong, nonatomic) IBOutlet UILabel *toDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *cellView;

@end
