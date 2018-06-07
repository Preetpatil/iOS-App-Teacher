//
//  LUAlertPopup.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^LUAlertBlock) (void);

typedef enum : NSUInteger {
    LUAlertPopupStyleDropDown,
} LUAlertPopupStyle;


@interface LUAlertPopup : UIView


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButton:(BOOL)cancelButton okButton:(BOOL)okButton sizeOfView:(CGRect)size;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButton:(BOOL)cancelButton okButton:(BOOL)okButton sizeOfView:(CGRect)size style:(LUAlertPopupStyle)animationStyle;


-(void)show;


@property(nonatomic,copy)LUAlertBlock cancelButtonClickedBlock;
@property(nonatomic,copy)LUAlertBlock okButtonClickedBlock;


@end
