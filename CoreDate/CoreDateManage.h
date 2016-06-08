//
//  CoreDateManage.h
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "Player.h"
#import "AppDelegate.h"

@interface CoreDateManage : NSObject

+ (instancetype) shareInstance;

/**
 *  创建球队
 *
 *  @param teamName  队名
 *  @param teamCity  所在城市
 *  @param memberNum 球队人数
 *
 *  @return YES NO
 */
- (BOOL)createTeamWithName:(NSString *)teamName city:(NSString *)teamCity menberNum:(NSInteger) memberNum;

/**
 *  创建球员
 *
 *  @param playerName 球员名字
 *  @param age        球员年龄
 *  @param teamName   所属球队名
 *
 *  @return YES OR NO
 */
- (BOOL)createPlayEithName:(NSString *)playerName withPlayerAge:(NSInteger) age withTeamName:(NSString *)teamName;

- (Team *)getTeamInfoByName:(NSString *)teamName;

- (Player *)getPlayerInfoByName:(NSString *)playerName withTeamName:(NSString *)teamName;

/**
 *  查询
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)fetchListWithEntityName:(NSString *)name;

/**
 *  通过队名查询该队的所有队员
 *
 *  @param teamName 队名
 *
 *  @return <#return value description#>
 */
- (NSArray *)fetchAllPlayersFromTeamName:(NSString *)teamName;

/**
 *  修改球员信息
 *
 *  @param playerInfo Player Entity
 *
 *  @return YES OR NO 
 */
- (BOOL) changePlayerInfo:(Player *)playerInfo ;

@end
