 //
//  LUTeacherResourceLibraryViewController.m
//  //  LUTeacher
//
//  Created by Preeti Patil on 18/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTeacherResourceLibraryViewController.h"

@implementation LUTeacherResourceLibraryViewController

{
     NSMutableArray *resourceClassList,*resourceClassId,*resourceSubjectList,*resourceSubjectId,*resourceUnitData,*subjectDetails;
    __weak IBOutlet UIButton *backToClass;
    NSString *classID,*subjectID;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    backToClass.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    resourceClassList = [[NSMutableArray alloc]init];
    subjectDetails = [[NSMutableArray alloc]init];
    resourceSubjectList = [[NSMutableArray alloc]init];
    resourceUnitData = [[NSMutableArray alloc]init];
    resourceClassId = [[NSMutableArray alloc]init];
    resourceSubjectId = [[NSMutableArray alloc]init];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherResourceLibraryList:Teacher_resource_library];

}
-(void)teacherResourcesLibraryList:(NSDictionary *)teachersResoureList
{
   
    if ([teachersResoureList objectForKey:@"ResourceBank"] == nil )
    {
       
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Empty"
                                     message:@"No resource fould"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                      
                                     
                                    }];
       
       
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    else
    {
        NSArray *arr1 = [teachersResoureList objectForKey:@"ResourceBank"];
        for (int i=0; i<arr1.count; i++)
        {
            NSDictionary *dict1 = [arr1 objectAtIndex:i];
            NSLog(@"%@",dict1);
            [resourceClassList addObject:[dict1 objectForKey:@"ClassName"]];
        
            [resourceClassId addObject:[dict1 objectForKey:@"Id"]];
        
        
            [subjectDetails addObject:[dict1 objectForKey:@"subjectdata"]];
        
        
        }
        [_teacherResourceTable reloadData];
    
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (resourceSubjectList.count!=0)
    {
        return resourceSubjectList.count;
    }else
    {
        return resourceClassList.count;
    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resourceCELL" forIndexPath:indexPath];
    UILabel *subLbl = (UILabel *)[cell viewWithTag:100];
    if (resourceSubjectList.count != 0) {
        subLbl.text = [resourceSubjectList objectAtIndex:indexPath.row];
    }else{
        subLbl.text = [resourceClassList objectAtIndex:indexPath.row];
 
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (resourceSubjectList.count == 0)
    {
      classID =   [resourceClassId objectAtIndex:indexPath.row];
        
        NSArray *arr1 = [subjectDetails objectAtIndex:indexPath.row];
        for (int i=0; i<arr1.count; i++)
        {
            NSDictionary *dict1 = [arr1 objectAtIndex:i];
            [resourceSubjectList addObject: [dict1 objectForKey:@"SubjectName"]];
            [resourceSubjectId addObject: [dict1 objectForKey:@"Id"]];
            [resourceUnitData addObject:[dict1 objectForKey:@"unitdata"]];
            NSLog(@"%@",resourceSubjectList );
        }
        backToClass.hidden = NO;
        [_teacherResourceTable reloadData];
    }
    else
    {
       subjectID = [resourceSubjectId objectAtIndex:indexPath.row];
        
        LUShelfListViewController *pushToShelf = [self.storyboard instantiateViewControllerWithIdentifier:@"LUStudentNotesVC"];
        pushToShelf.setTeacherResource = YES;
        pushToShelf.setResource = YES;
        pushToShelf.header = [resourceSubjectList objectAtIndex:indexPath.row];
        pushToShelf.resourceSubjectName = [resourceSubjectList objectAtIndex:indexPath.row];
        pushToShelf.resourceSubjectList = [resourceUnitData objectAtIndex:indexPath.row];
        pushToShelf.classId = classID;
        pushToShelf.subjectId = subjectID;
        [self.navigationController pushViewController:pushToShelf animated:YES];
    }
}
- (IBAction)backToClass:(id)sender
{
    backToClass.hidden = YES;
    [resourceSubjectList removeAllObjects];
    [_teacherResourceTable reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
