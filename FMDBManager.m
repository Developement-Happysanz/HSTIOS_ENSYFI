//
//  FMDBManager.m
//  EducationApp
//
//  Created by HappySanz on 12/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager ()

@end

@implementation FMDBManager

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
-(void)insertdata:(NSDictionary *)dict
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    BOOL isInserted=[database executeUpdate:@"INSERT INTO table_create_exams_of_the_class (Fromdate) VALUES (?)"];
    [database close];
    
    if(isInserted)
        NSLog(@"Inserted Successfully");
    else
        NSLog(@"Error occured while inserting");
}
@end
