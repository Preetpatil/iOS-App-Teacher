//
//  LUTeachersNotesCreateViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeachersNotesCreateViewController.h"

@interface LUTeachersNotesCreateViewController ()

@end

@implementation LUTeachersNotesCreateViewController{
    NSMutableArray *classList,*tempArr1,*subjectList,*tempArr2,*unitList,*tempArr3,*topicList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton notesCreateInput:NotesCreateInput];
    
   // NotesCreateInput
    
    
    // Do any additional setup after loading the view.
}
-(void)getPagetype
{
  
    
    

}
-(void)initialise
{
    classList = [[NSMutableArray alloc]init];
    tempArr1 = [[NSMutableArray alloc]init];
    tempArr2 = [[NSMutableArray alloc]init];
    tempArr3 = [[NSMutableArray alloc]init];
}

-(void) notesCreateInputResponse: (NSDictionary *) createResponse
{
    
    for (int i=0; i<[[createResponse objectForKey:@"NotesCategory"] count] ; i++)
    {
         [classList addObject:[[[createResponse objectForKey:@"NotesCategory"] objectAtIndex:i] objectForKey:@"ClassName"]];
        [tempArr1 addObject:[[[createResponse objectForKey:@"NotesCategory"] objectAtIndex:i] objectForKey:@"subjectdata"]];
    }
   
    [_classPicker reloadAllComponents ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCover:(id)sender
{
}



- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == _classPicker)
    {
        return classList.count;
    }else if (pickerView == _subjectPicker)
    {
         return subjectList.count;
    }else if (pickerView == _unitPicker)
    {
         return unitList.count;
    }else if (pickerView == _topicPicker)
    {
         return topicList.count;
    }else if (pickerView == _pageTypePicker)
    {
         return 0;
    }
    else
    {
        return 0;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if (pickerView == _classPicker)
    {
        return classList[row];
    }else if (pickerView == _subjectPicker)
    {
        return subjectList[row];
    }else if (pickerView == _unitPicker)
    {
        return unitList[row];
    }else if (pickerView == _topicPicker)
    {
        return topicList[row];
    }else if (pickerView == _pageTypePicker)
    {
        return 0;
    }
    else
    {
        return 0;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    if (pickerView == _classPicker)
    {
        [tempArr1 objectAtIndex:[classList indexOfObject:[classList objectAtIndex:row]]];
        subjectList = [[NSMutableArray alloc]init];
        for (int i=0; i<[[tempArr1 objectAtIndex:[classList indexOfObject:[classList objectAtIndex:row]]] count]; i++)
        {
            [subjectList addObject:[[[tempArr1 objectAtIndex:[classList indexOfObject:[classList objectAtIndex:row]]] objectAtIndex:i] objectForKey:@"SubjectName"]];
            
            [tempArr2 addObject:[[[tempArr1 objectAtIndex:[classList indexOfObject:[classList objectAtIndex:row]]] objectAtIndex:i] objectForKey:@"unitdata"]];
        }
        [_subjectPicker reloadAllComponents];
    }
    else if (pickerView == _subjectPicker)
    {
        [tempArr2 objectAtIndex:[subjectList indexOfObject:[subjectList objectAtIndex:row]]];
        unitList = [[NSMutableArray alloc]init];
        for (int i=0; i<[[tempArr2 objectAtIndex:[subjectList indexOfObject:[subjectList objectAtIndex:0]]] count ]; i++)
        {
            [unitList addObject:[[[tempArr2 objectAtIndex:[subjectList indexOfObject:[subjectList objectAtIndex:0]]] objectAtIndex:i] objectForKey:@"UnitName"]];
            [tempArr3 addObject:[[[tempArr2 objectAtIndex:[subjectList indexOfObject:[subjectList objectAtIndex:0]]] objectAtIndex:i] objectForKey:@"topicdata"]];
        }
        [_unitPicker reloadAllComponents];
    }
    else if (pickerView == _unitPicker)
    {
       [tempArr3 objectAtIndex:[unitList indexOfObject:[unitList objectAtIndex:row]]];
        topicList = [[NSMutableArray alloc]init];
        for (int i=0; i<[[tempArr3 objectAtIndex:[unitList indexOfObject:[unitList objectAtIndex:row]]] count ]; i++)
        {
            [topicList addObject:[[[tempArr3 objectAtIndex:[unitList indexOfObject:[unitList objectAtIndex:row]]] objectAtIndex:i] objectForKey:@"TopicName"]];
        }
        [_topicPicker reloadAllComponents];
    }else if (pickerView == _topicPicker)
    {
      
    }
    else if (pickerView == _pageTypePicker)
    {
       
    }
    else
    {
      
    }
    
    
    
}
 
@end
