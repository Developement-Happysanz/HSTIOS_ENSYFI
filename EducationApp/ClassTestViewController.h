//
//  ClassTestViewController.h
//  EducationApp
//
//  Created by HappySanz on 16/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTestViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)segmentcontrolAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)homeworkSwtchBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *homeworkSwtch;
- (IBAction)classTestSwtchBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *classTestSwtch;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
