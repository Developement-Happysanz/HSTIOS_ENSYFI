//
//  TeacherApplyLeaveCell.h
//  EducationApp
//
//  Created by HappySanz on 20/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherApplyLeaveCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *fromdate;
@property (strong, nonatomic) IBOutlet UILabel *todate;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;

@end
