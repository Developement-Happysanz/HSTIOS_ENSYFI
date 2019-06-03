//
//  ClassTeacherHomeWorkView.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 21/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTeacherHomeWorkView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;

@end
