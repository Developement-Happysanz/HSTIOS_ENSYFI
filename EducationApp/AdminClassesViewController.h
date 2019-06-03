//
//  AdminClassesViewController.h
//  EducationApp
//
//  Created by HappySanz on 21/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminClassesViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>
{
    NIDropDown *dropDown;

}
@property (strong, nonatomic) IBOutlet UILabel *title2Label;
@property (strong, nonatomic) IBOutlet UILabel *titleName;
- (IBAction)segmentBTn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionBtnOtlet;
@property (strong, nonatomic) IBOutlet UIButton *classBtnOtlet;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)sectionBtn:(id)sender;
- (IBAction)classBTn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
