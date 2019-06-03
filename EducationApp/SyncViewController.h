//
//  SyncViewController.h
//  EducationApp
//
//  Created by HappySanz on 23/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UIButton *attendanceSync;
- (IBAction)attendanceSyncBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *classtestSync;
- (IBAction)classTestSyncBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *refreshsync;
- (IBAction)resfreshSyncBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *classTestMarkSync;
- (IBAction)classTestMarkSyncBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *examSync;
- (IBAction)examSyncBtn:(id)sender;

@end
