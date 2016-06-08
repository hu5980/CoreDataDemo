//
//  Team+CoreDataProperties.h
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Team.h"

NS_ASSUME_NONNULL_BEGIN

@interface Team (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *teamName;
@property (nullable, nonatomic, retain) NSNumber *teamMemberNum;
@property (nullable, nonatomic, retain) NSString *teamCity;

@end

NS_ASSUME_NONNULL_END
