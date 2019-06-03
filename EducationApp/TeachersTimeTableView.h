//
//  TeachersTimeTableView.h
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachersTimeTableView : UIViewController<UIGestureRecognizerDelegate>

- (IBAction)viewBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *mondayPeriod1;
@property (strong, nonatomic) IBOutlet UIButton *mondayPeriod1Otlet;
- (IBAction)mondayPeriod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tudesdayPeriod1;
@property (strong, nonatomic) IBOutlet UIButton *tudedayPeriod1Otlet;
- (IBAction)tudesdayperiod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayPeriod1;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod1Otlet;
- (IBAction)wednesdayPeriod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod1;
@property (strong, nonatomic) IBOutlet UIButton *thursadayperiod1Otlet;
- (IBAction)thursadyaperiod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod1;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod1Otlet;
- (IBAction)fdayperiod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod1;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod1Otlet;
- (IBAction)satdayperiod1Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod2;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod2;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod2;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod2;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod2;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod2;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod2Otlet;
- (IBAction)mondayperiod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod2Otlet;
- (IBAction)tuesdayperiod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod2Otlet;
- (IBAction)wednesdayperiod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *thursadayperiod2Otlet;
- (IBAction)thursadayperiod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod2Otlet;
- (IBAction)fdayPeriod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod2Otlet;
- (IBAction)satdayperiod2Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod3;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod3;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod3;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod3;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod3;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod3;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod3Otlet;
@property (strong, nonatomic) IBOutlet UIButton *tudesdayperiod3Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod3Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursadayperiod3Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod3Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod3Otlet;
- (IBAction)mondayperiod3Btn:(id)sender;
- (IBAction)tuesdayperiod3Btn:(id)sender;
- (IBAction)wednesdayperiod3Btn:(id)sender;
- (IBAction)thursadayperiod3Btn:(id)sender;
- (IBAction)fdayperiod3Btn:(id)sender;
- (IBAction)satdayperiod3Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod4;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod4;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod4;
@property (strong, nonatomic) IBOutlet UILabel *thursadayperiod4;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod4;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod4;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod4Otlet;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod4Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod4Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursdayperiod4Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod4Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod4Otlet;
- (IBAction)mondayperiod4Btn:(id)sender;
- (IBAction)tuesdayperiod4Btn:(id)sender;
- (IBAction)wednesdayperiod4Btn:(id)sender;
- (IBAction)thursadayperiod4Btn:(id)sender;
- (IBAction)fdayperiod4Btn:(id)sender;
- (IBAction)satdayperiod4Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod5;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod5;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod5;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod5;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod5;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod5;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod5Otlet;


@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod5Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod5Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursdayperiod5Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod5Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod5Otlet;
- (IBAction)mondayperiod5Btn:(id)sender;
- (IBAction)tuesdayperiod5Btn:(id)sender;
- (IBAction)wednesdayperiod5Btn:(id)sender;
- (IBAction)thursdayperiod5Btn:(id)sender;
- (IBAction)fdayperiod5Btn:(id)sender;
- (IBAction)satdayperiod5Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod6;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod6;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod6;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod6;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod6;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod6;
- (IBAction)mondayperiod6Btn:(id)sender;
- (IBAction)tuesdayperiod6Btn:(id)sender;
- (IBAction)wednesdayperiod6Btn:(id)sender;
- (IBAction)thursdayperiod6Btn:(id)sender;
- (IBAction)fsayperiod6Btn:(id)sender;
- (IBAction)satdayperiod6Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod7;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod7;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod7;
@property (strong, nonatomic) IBOutlet UILabel *thursadayperiod7;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod7;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod7;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod7Otlet;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod7Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod7Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursdayperiod7Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod7Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod7Otlet;
- (IBAction)mondayperiod7Btn:(id)sender;
- (IBAction)tuedayperiod7Btn:(id)sender;
- (IBAction)wednesdayperiod7Btn:(id)sender;
- (IBAction)thursdayperiod7Btn:(id)sender;
- (IBAction)fdayperiod7Btn:(id)sender;
- (IBAction)satdayperiod7Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mondayperiod8;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayperiod8;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayperiod8;
@property (strong, nonatomic) IBOutlet UILabel *thursdayperiod8;
@property (strong, nonatomic) IBOutlet UILabel *fdayperiod8;
@property (strong, nonatomic) IBOutlet UILabel *satdayperiod8;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod8Otlet;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod8Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod8Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursdayperiod8Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod8Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod8Otlet;
- (IBAction)mondayperiod8Btn:(id)sender;
- (IBAction)tuesdayperiod8Btn:(id)sender;
- (IBAction)wednesdayperiod8Btn:(id)sender;
- (IBAction)thursdayperiod8Btn:(id)sender;
- (IBAction)fdayperiod8Btn:(id)sender;
- (IBAction)satdayperiod8Btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mondayperiod6Otlet;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayperiod6Otlet;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayperiod6Otlet;
@property (strong, nonatomic) IBOutlet UIButton *thursdayperiod6Otlet;
@property (strong, nonatomic) IBOutlet UIButton *fdayperiod6Otlet;
@property (strong, nonatomic) IBOutlet UIButton *satdayperiod6Otlet;


@end
