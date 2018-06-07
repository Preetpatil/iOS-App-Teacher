//
//  LUMatchQuestionCell.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUMatchQuestionCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *matchOption;
@property (weak, nonatomic) IBOutlet UITextField *matchingAnswer;

@property (weak, nonatomic) IBOutlet UILabel *matchQuestions;
@end
