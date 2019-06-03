//
//  AdminResultView.h
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminResultView : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDelegate,NIDropDownDelegate>
{
    NIDropDown *dropdown;
}
- (IBAction)sectionBtn:(id)sender;
- (IBAction)classBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *classOtlet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
