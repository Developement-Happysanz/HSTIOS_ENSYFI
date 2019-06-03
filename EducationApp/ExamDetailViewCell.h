//
//  ExamDetailViewCell.h
//  EducationApp
//
//  Created by HappySanz on 17/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectlabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLebel1;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)viewmarkButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *viewmark;

@end
