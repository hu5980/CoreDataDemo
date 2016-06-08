//
//  CoreDateManage.m
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import "CoreDateManage.h"


static CoreDateManage *shareInstance;
static NSManagedObjectContext *managedObjectContext;
static AppDelegate *appDelegate;
@implementation CoreDateManage
 

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
        managedObjectContext = appDelegate.managedObjectContext;
        shareInstance = [[CoreDateManage alloc] init];
    });
    return shareInstance;
}


// 1.第一种插入
- (BOOL)createTeamWithName:(NSString *)teamName city:(NSString *)teamCity menberNum:(NSInteger) memberNum
{
    if (!teamName || !teamCity || !memberNum) {
        return NO;
    }
    
    Team *teamObject = [self getTeamInfoByName:teamName];
    if (teamObject == nil) {
        teamObject = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:managedObjectContext];
        [teamObject setValue:teamName forKey:@"teamName"];
        [teamObject setValue:teamCity forKey:@"teamCity"];
        [teamObject setValue:[NSNumber numberWithInteger:memberNum] forKey:@"teamMemberNum"];
        return YES;
    }else{
        return NO;
    }
}

// 2.第二种插入
- (BOOL)createPlayEithName:(NSString *)playerName withPlayerAge:(NSInteger) age withTeamName:(NSString *)teamName{
    if (!playerName || !age) {
        return NO;
    }
    Player *player = [self getPlayerInfoByName:playerName withTeamName:teamName];
    if (nil == player ) {
        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
        [player setName:playerName];
        [player setAge:[NSNumber numberWithInteger:age]];
        [player setTeamName:teamName];
        return YES;
    }else{
        return NO;
    }
}


- (Team *)getTeamInfoByName:(NSString *)teamName
{
    Team *teamObject = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teamName == %@", teamName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = NULL;
    NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    
    if (array && [array count] > 0) {
        teamObject = [array objectAtIndex:0];
    }
    return teamObject;
}


- (Player *)getPlayerInfoByName:(NSString *)playerName withTeamName:(NSString *)teamName
{
    Player *playerObject = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@ and teamName == %@", playerName,teamName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = NULL;
    NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    
    if (array && [array count] > 0) {
        playerObject = [array objectAtIndex:0];
    }
    
    return playerObject;
}

//查询全部
- (NSArray *)fetchListWithEntityName:(NSString *)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:name inManagedObjectContext:managedObjectContext]];
    
    NSError *error = NULL;
    NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    return array;
}


@end
