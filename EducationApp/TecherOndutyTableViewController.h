//
//  TecherOndutyTableViewController.h
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TecherOndutyTableViewController : UITableViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *plusOtlet;
- (IBAction)odFormBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarBtn;

@end
