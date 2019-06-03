//
//  ExamMarkViewController.h
//  EducationApp
//
//  Created by HappySanz on 25/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamMarkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *TotalstatLabel;
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UIView *subview;

@end
