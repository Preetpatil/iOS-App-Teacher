//
//
//  LUShelfCollectionViewCell.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface LUShelfCollectionViewCell : UICollectionViewCell

@property (weak) IBOutlet UIImageView *CoverImage;
@property (weak) IBOutlet UILabel *UnitNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *UnitNameLabel;

@end
