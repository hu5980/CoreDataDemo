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
        [appDelegate saveContext];
        return YES;
    }else{
        return NO;
    }
}

// 2.第二种插入
- (BOOL)createPlayEithName:(NSString *)playerName withPlayerAge:(NSInteger) age withTeamName:(NSString *)teamName{
    if (!playerName || !age || !teamName) {
        return NO;
    }
    Player *player = [self getPlayerInfoByName:playerName withTeamName:teamName];
    if (nil == player ) {
        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
        [player setName:playerName];
        [player setAge:[NSNumber numberWithInteger:age]];
        [player setTeamName:teamName];
        
        [appDelegate saveContext];
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

//查询Entity 全部数据
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

// 查询球队的所有球员
- (NSArray *)fetchAllPlayersFromTeamName:(NSString *)teamName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"teamName == %@",teamName];
    
    //按照升序 查询
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *playerArray =  [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return playerArray;
}


- (BOOL) updatePlayerInfo:(Player *)playerInfo {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",playerInfo.name];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:managedObjectContext]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    

    NSError *error = nil;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (Player *player in result) {
        player.age = playerInfo.age;
    }
    
    //保存
    if ([managedObjectContext save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
    
    return  NO;
}


- (BOOL) deletePlayer:(Player *)playerInfo {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",playerInfo.name];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:managedObjectContext]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    
    
    NSError *error = nil;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    if (result.count && !error && result) {
        for (NSManagedObject *obj in result)
        {
            [managedObjectContext deleteObject:obj];
        }
        
        return YES;
    }
    return NO;
}

@end
