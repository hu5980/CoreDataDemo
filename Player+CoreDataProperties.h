//
//  Player+CoreDataProperties.h
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Player.h"
#import "Team.h"
NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *teamName;
@property (nullable, nonatomic, retain) Team *team;

@end

NS_ASSUME_NONNULL_END
