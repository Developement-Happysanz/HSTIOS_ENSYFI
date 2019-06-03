//
//  ExamTestMarkView.h
//  EducationApp
//
//  Created by HappySanz on 21/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamTestMarkView : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *TotalStaLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *totalMarks;
@property (strong, nonatomic) IBOutlet UIView *subview;


@end
