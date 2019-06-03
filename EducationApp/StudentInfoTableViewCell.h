//
//  StudentInfoTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 06/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *classid;
@property (strong, nonatomic) IBOutlet UILabel *classnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *admissionidLabel;
@property (strong, nonatomic) IBOutlet UILabel *studentidLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end
