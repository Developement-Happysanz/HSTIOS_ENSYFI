//
//  ClassTestTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 20/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *testDateLabel;
@property (weak, nonatomic) IBOutlet UIView *cellview;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectName;

@property (weak, nonatomic) IBOutlet UILabel *subjectTitle;

@end
