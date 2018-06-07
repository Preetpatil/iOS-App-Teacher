//
//  LUTeachersNotesCreateViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
#import "LUOperation.h"
@interface LUTeachersNotesCreateViewController : UIViewController<LUDelegate,UIPickerViewDelegate,UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIPickerView *classPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *unitPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *subjectPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *topicPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pageTypePicker;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;


@end
