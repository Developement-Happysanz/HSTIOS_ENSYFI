//
//  TeachersTimeTableView.m
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeachersTimeTableView.h"

@interface TeachersTimeTableView ()
{
    NSArray *dayArray;
    NSArray *listday_Array;
    NSMutableArray *class_id;
    NSMutableArray *from_time;
    NSMutableArray *is_break;
    NSMutableArray *name;
    NSMutableArray *period;
    NSMutableArray *subject_name;
    NSMutableArray *to_time;
    NSMutableArray *day_idArr;
    NSMutableArray *break_name;
    AppDelegate *appDel;
    
    NSArray *docPaths;
    NSString *documentsDir;
    NSString *dbPath;
    FMDatabase *database;
    FMResultSet *rs;
    
    
}
@property (readwrite) NSInteger selected_id;
@end

@implementation TeachersTimeTableView


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([str isEqualToString:@"admin"])
    {
        UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
        button2.tintColor = UIColor.whiteColor;
        self.navigationItem.leftBarButtonItem = button2;
    }
    else
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if (revealViewController)
        {
            [self.sidebar setTarget: self.revealViewController];
            [self.sidebar setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
    class_id = [[NSMutableArray alloc]init];
    from_time = [[NSMutableArray alloc]init];
    is_break = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    period = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    to_time = [[NSMutableArray alloc]init];
    day_idArr = [[NSMutableArray alloc]init];
    break_name = [[NSMutableArray alloc]init];
    
    listday_Array = @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    dayArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:listday_Array];
    _segmentedControl.frame = CGRectMake(0,0,self.view.bounds.size.width,55);
    _segmentedControl.selectionIndicatorHeight = 4.0f;
    _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    _segmentedControl.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0];
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    NSString *strcount;
    NSString *firstObject = [listday_Array objectAtIndex:0];
    NSUInteger integer = [listday_Array indexOfObject:firstObject];
    NSString *day_id = dayArray[integer];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT COUNT(*) as count FROM table_create_teacher_timetable"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"count :%d",[rs intForColumn:@"count"]);
            strcount = [rs stringForColumn:@"count"];
        }
    }
    [database close];
    
    if(![strcount isEqualToString:@"0"])
    {
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select break_name,class_id,day_id,from_time,is_break,name,period,subject_name,to_time,day_id from table_create_teacher_timetable where day_id = ?",@"1"];
        
        [class_id removeAllObjects];
        [day_idArr removeAllObjects];
        [from_time removeAllObjects];
        [is_break removeAllObjects];
        [name removeAllObjects];
        [period removeAllObjects];
        [subject_name removeAllObjects];
        [to_time removeAllObjects];
        [break_name removeAllObjects];
        
        if(rs)
        {
            while ([rs next])
            {
                NSString *strbreak_name = [rs stringForColumn:@"break_name"];
                NSString *strclass_id = [rs stringForColumn:@"class_id"];
//              NSString *strclass_name = [rs stringForColumn:@"class_name"];
                NSString *strday_id = [rs stringForColumn:@"day_id"];
                NSString *strfrom_time = [rs stringForColumn:@"from_time"];
                NSString *stris_break = [rs stringForColumn:@"is_break"];
                NSString *strname = [rs stringForColumn:@"name"];
                NSString *strperiod = [rs stringForColumn:@"period"];
//              NSString *strsec_name = [rs stringForColumn:@"sec_name"];
//              NSString *strsubject_id = [rs stringForColumn:@"subject_id"];
                NSString *strsubject_name = [rs stringForColumn:@"subject_name"];
//              NSString *strtable_id = [rs stringForColumn:@"table_id"];
//              NSString *strteacher_id = [rs stringForColumn:@"teacher_id"];
                NSString *strto_time = [rs stringForColumn:@"to_time"];

                
                [class_id addObject:strclass_id];
                [day_idArr addObject:strday_id];
                [from_time addObject:strfrom_time];
                [is_break addObject:stris_break];
                [name addObject:strname];
                [period addObject:strperiod];
                [subject_name addObject:strsubject_name];
                [to_time addObject:strto_time];
                [break_name addObject:strbreak_name];
            }
        }
        [database close];
    }
        
                 
        [self.tableView reloadData];

}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [period count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTimeTableTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    cell.staffName.text = [name objectAtIndex:indexPath.row];
    NSString *strPeriod = [NSString stringWithFormat:@"%@%@",@"0",[period objectAtIndex:indexPath.row]];
    cell.period.text = strPeriod;
    NSString *time = [NSString stringWithFormat:@"%@ - %@",[from_time objectAtIndex:indexPath.row],[to_time objectAtIndex:indexPath.row]];
    cell.time.text = time;
    NSString *text = [is_break objectAtIndex:indexPath.row];
    if ([text isEqualToString:@"1"])
    {
        cell.subjectName.hidden = YES;
        cell.lineTwo.hidden = YES;
        cell.lineOne.hidden = YES;
        cell.period.hidden = YES;
        cell.time.hidden = YES;
        cell.statPeriodLabel.hidden = YES;
        cell.calenderImageview.hidden = YES;
        cell.staffName.hidden = YES;
        cell.breakLabel.hidden = NO;
        cell.breakLabel.text = [NSString stringWithFormat:@"%@ - %@",[break_name objectAtIndex:indexPath.row],time];
        //cell.cellView.layer.cornerRadius = 5.0;
        //cell.cellView.clipsToBounds = YES;
        cell.cellView.backgroundColor = [UIColor colorWithRed:231/255.0f green:167/255.0f blue:93/255.0f alpha:1.0];
    }
    else
    {
        cell.breakLabel.hidden = YES;
        cell.subjectName.hidden = NO;
        cell.staffName.hidden = NO;
        cell.lineTwo.hidden = NO;
        cell.lineOne.hidden = NO;
        cell.period.hidden = NO;
        cell.calenderImageview.hidden = NO;
        cell.statPeriodLabel.hidden = NO;
        cell.time.hidden = NO;
        //cell.cellView.layer.cornerRadius = 5.0;
        //cell.cellView.clipsToBounds = YES;
        cell.cellView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.cellView.layer.cornerRadius = 8.0f;
    cell.cellView.clipsToBounds = YES;
    
    cell.cellView.layer.shadowRadius  = 5.5f;
    cell.cellView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.cellView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.cellView.layer.shadowOpacity = 0.6f;
    cell.cellView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.cellView.bounds, shadowInsets)];
    cell.cellView.layer.shadowPath    = shadowPath.CGPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [is_break objectAtIndex:[indexPath row]];
    if ([text isEqualToString:@"1"])
    {
        return 75;
    }
    else
    {
        return 135;
    }
}
-(void)segmentAction:(UISegmentedControl *)sender
{
    NSString *strcount;
    _selected_id = _segmentedControl.selectedSegmentIndex;
    NSString *selected_day = [listday_Array objectAtIndex:_selected_id];
    NSUInteger integer = [listday_Array indexOfObject:selected_day];
    NSString *day_id = dayArray[integer];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT COUNT(*) as count FROM table_create_teacher_timetable"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"count :%d",[rs intForColumn:@"count"]);
            strcount = [rs stringForColumn:@"count"];
        }
    }
    [database close];
    
    if(![strcount isEqualToString:@"0"])
    {
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select break_name,class_id,day_id,from_time,is_break,name,period,subject_name,to_time,day_id from table_create_teacher_timetable where day_id = ?",day_id];
        
        [class_id removeAllObjects];
        [day_idArr removeAllObjects];
        [from_time removeAllObjects];
        [is_break removeAllObjects];
        [name removeAllObjects];
        [period removeAllObjects];
        [subject_name removeAllObjects];
        [to_time removeAllObjects];
        [break_name removeAllObjects];
        
        if(rs)
        {
            while ([rs next])
            {
                NSString *strbreak_name = [rs stringForColumn:@"break_name"];
                NSString *strclass_id = [rs stringForColumn:@"class_id"];
                //NSString *strclass_name = [rs stringForColumn:@"class_name"];
                NSString *strday_id = [rs stringForColumn:@"day_id"];
                NSString *strfrom_time = [rs stringForColumn:@"from_time"];
                NSString *stris_break = [rs stringForColumn:@"is_break"];
                NSString *strname = [rs stringForColumn:@"name"];
                NSString *strperiod = [rs stringForColumn:@"period"];
                //NSString *strsec_name = [rs stringForColumn:@"sec_name"];
                //NSString *strsubject_id = [rs stringForColumn:@"subject_id"];
                NSString *strsubject_name = [rs stringForColumn:@"subject_name"];
                //NSString *strtable_id = [rs stringForColumn:@"table_id"];
                //NSString *strteacher_id = [rs stringForColumn:@"teacher_id"];
                NSString *strto_time = [rs stringForColumn:@"to_time"];
                
                
                [class_id addObject:strclass_id];
                [day_idArr addObject:strday_id];
                [from_time addObject:strfrom_time];
                [is_break addObject:stris_break];
                [name addObject:strname];
                [period addObject:strperiod];
                [subject_name addObject:strsubject_name];
                [to_time addObject:strto_time];
                [break_name addObject:strbreak_name];
            }
        }
        [database close];
        [self.tableView reloadData];
    }
    
    
}
@end
