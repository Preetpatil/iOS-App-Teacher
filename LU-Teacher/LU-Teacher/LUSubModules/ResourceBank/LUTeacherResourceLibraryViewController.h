//
//  LUTeacherResourceLibraryViewController.h
//  //  LUTeacher
//
//  Created by Preeti Patil on 18/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#ifndef LUTeacherResourceLibraryViewController_h
#define LUTeacherResourceLibraryViewController_h


#endif /* LUTeacherResourceLibraryViewController_h */

#import <UIKit/UIKit.h>
#import "LUHeader.h"

@interface LUTeacherResourceLibraryViewController : UIViewController<LUDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *teacherResourceTable;


@end
