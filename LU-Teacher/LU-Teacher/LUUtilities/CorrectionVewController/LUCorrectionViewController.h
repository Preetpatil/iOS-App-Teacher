//
//  CorrectionViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
@class LUNotesDrawingView;
@interface LUCorrectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet LUNotesDrawingView *CorrectionDrawView;

@property (weak, nonatomic) IBOutlet UIButton *undo;
@property (weak, nonatomic) IBOutlet UIButton *redo;
@property (weak, nonatomic) IBOutlet UIButton *thumbnail;
@property (weak, nonatomic) IBOutlet UIButton *redWrite;
@property (weak, nonatomic) IBOutlet UIButton *blueWrite;

@property (weak, nonatomic) IBOutlet UIView *thumbnailView;
@property (weak, nonatomic) IBOutlet UICollectionView *thumbnailCollection;

@end
