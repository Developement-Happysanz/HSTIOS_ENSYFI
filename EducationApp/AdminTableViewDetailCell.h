//
//  AdminTableViewDetailCell.h
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTableViewDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *fessId;
@property (strong, nonatomic) IBOutlet UILabel *toDate;
@property (strong, nonatomic) IBOutlet UILabel *fromDate;
@property (strong, nonatomic) IBOutlet UILabel *toYear;
@property (strong, nonatomic) IBOutlet UILabel *fromYear;
@property (strong, nonatomic) IBOutlet UILabel *termName;

@end
