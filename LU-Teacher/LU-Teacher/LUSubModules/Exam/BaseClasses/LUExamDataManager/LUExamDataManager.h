//
//  LUExamDataManager.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface LUExamDataManager : NSObject
{
    
    NSString *DataPath;
}

+(LUExamDataManager*)getSharedInstance;
-(BOOL)createExamDB:(NSString*)DBName;

-(BOOL)saveExamDB:(NSString*)PageNo QusetiontypeId:(NSString *)QuestionTypeID QusetiontypeName:(NSString *)QuestionTypeName QusetionId:(NSString *)QuestionID Correctoption:(NSString *)CorrectOption Pageimage:(NSData *)PageImage questionno:(NSString *)QNo DB:(NSString *)DBName ;

-(BOOL)updateExamDB:(NSString*)PageNo QusetiontypeId:(NSString *)QuestionTypeID QusetiontypeName:(NSString *)QuestionTypeName QusetionId:(NSString *)QuestionID Correctoption:(NSString *)CorrectOption Pageimage:(NSData *)PageImage questionno:(NSString *)QNo DB:(NSString *)DBName  ;

-(NSArray*)ShowAllExam:(NSString*)DBName qno:(NSString *)qNo;



@end
