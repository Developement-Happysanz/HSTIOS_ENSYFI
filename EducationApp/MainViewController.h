//
//  MainViewController.h
//  EducationApp
//
//  Created by HappySanz on 12/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
