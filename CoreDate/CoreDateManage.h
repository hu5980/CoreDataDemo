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

- (BOOL)createTeamWithName:(NSString *)teamName city:(NSString *)teamCity menberNum:(NSInteger) memberNum;

- (BOOL)createPlayEithName:(NSString *)playerName withPlayerAge:(NSInteger) age withTeamName:(NSString *)teamName;

- (Team *)getTeamInfoByName:(NSString *)teamName;

- (Player *)getPlayerInfoByName:(NSString *)playerName withTeamName:(NSString *)teamName;

- (NSArray *)fetchListWithEntityName:(NSString *)name;

@end
