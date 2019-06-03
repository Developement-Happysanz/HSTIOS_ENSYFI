//
//  TeacherTimeTableNotes.h
//  EducationApp
//
//  Created by HappySanz on 13/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherTimeTableNotes : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
