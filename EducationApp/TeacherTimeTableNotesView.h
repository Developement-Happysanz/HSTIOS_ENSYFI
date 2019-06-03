//
//  TeacherTimeTableNotesView.h
//  EducationApp
//
//  Created by HappySanz on 13/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherTimeTableNotesView : UIViewController
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *classnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectName;
@property (strong, nonatomic) IBOutlet UILabel *periodLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarksLabel;

@end
