//
//  AdminResultTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminResultTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *seprateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *calenderImg;
@property (strong, nonatomic) IBOutlet UILabel *examId;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
