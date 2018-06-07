//
//  LUTeacherMainDrawingViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#ifndef LUTeacherMainDrawingViewController_h
#define LUTeacherMainDrawingViewController_h


#endif /* LUTeacherMainDrawingViewController_h */

#import <UIKit/UIKit.h>
#import "LUHeader.h"

@interface LUTeacherMainDrawingViewController : UIViewController<UITableViewDataSource, UIPickerViewDataSource,LUDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UIPickerView *classSelect;

@property (weak, nonatomic) IBOutlet UIPickerView *sectionSelect;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *studentListCollectionview;

@end

