//
//  TeacherClasstestHomeWorkView.h
//  EducationApp
//
//  Created by HappySanz on 06/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClasstestHomeWorkView : UIViewController<UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate,UIGestureRecognizerDelegate>
{
    NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UIButton *classSectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *categoeryOtlet;
- (IBAction)classSectionBtn:(id)sender;
- (IBAction)categoeryBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
- (IBAction)plusbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end
