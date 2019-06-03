//
//  AdminViewController.h
//  EducationApp
//
//  Created by HappySanz on 17/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminViewController : UIViewController<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;

@end
