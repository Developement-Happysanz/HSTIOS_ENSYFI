//
//  AttendanceDateView.h
//  EducationApp
//
//  Created by HappySanz on 04/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceDateView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
}
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *viewattendanceOtlet;

@end
