//
//  Player+CoreDataProperties.m
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Player+CoreDataProperties.h"
#define  PLAYER_ERROR_DOMAIN   @"PLAYER_ERROR_DOMAIN"

enum _playerErrorCode {
    PLAYER_INVALID_AGE_CODE = 0,
    PLAYER_INVALID_NAME_CODE,
    PLAYER_INVALID_CODE
};
typedef enum _playerErrorCode PlayerErrorCode;

@implementation Player (CoreDataProperties)

@dynamic age;
@dynamic name;
@dynamic teamName;
@dynamic team;

//插入验证
- (BOOL)validateForInsert:(NSError * _Nullable __autoreleasing *)error {
    
    BOOL valid = [super validateForInsert:error];
    
    NSString *playerName = self.name;
    if (!playerName || [playerName length] == 0) {
        if (error) {
            NSString *errorStr = @"Player's name should not be empty.";
            NSDictionary *userInfoDict = @{ NSLocalizedDescriptionKey : errorStr };
            NSError *error = [[NSError alloc] initWithDomain:PLAYER_ERROR_DOMAIN
                                                        code:PLAYER_INVALID_NAME_CODE
                                                    userInfo:userInfoDict];
            error = [self errorFromOriginalError:error error:nil];
        }
        valid = NO;
    }
    
    NSString *teamName = self.teamName;
    if (!teamName || [teamName length] == 0) {
        if (error) {
            NSString *errorStr = @"Team's name should not be empty.";
            NSDictionary *userInfoDict = @{ NSLocalizedDescriptionKey : errorStr };
            NSError *error = [[NSError alloc] initWithDomain:PLAYER_ERROR_DOMAIN
                                                        code:PLAYER_INVALID_NAME_CODE
                                                    userInfo:userInfoDict];
            error = [self errorFromOriginalError:error error:nil];
        }
        valid = NO;
    }
    
    NSInteger playerAge = [self.age integerValue];
    if (!self.age || (playerAge < 16 || playerAge > 50)) {
        if (error) {
            NSString *errorStr = @"Player's age should be in [16, 50].";
            NSDictionary *userInfoDict = @{ NSLocalizedDescriptionKey : errorStr };
            NSError *error = [[NSError alloc] initWithDomain:PLAYER_ERROR_DOMAIN
                                                        code:PLAYER_INVALID_AGE_CODE
                                                    userInfo:userInfoDict];
            error = [self errorFromOriginalError:error error:error];
        }
        valid = NO;
    }
    
    return valid;
}


- (NSError *)errorFromOriginalError:(NSError *)originalError error:(NSError *)secondError
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    NSMutableArray *errors = [NSMutableArray array];
    if (secondError) {
        [errors addObject:secondError];
    }
    
    if ([originalError code] == NSValidationMultipleErrorsError) {
        [userInfo addEntriesFromDictionary:[originalError userInfo]];
        [errors addObjectsFromArray:[userInfo objectForKey:NSDetailedErrorsKey]];
    } else {
        [errors addObject:originalError];
    }
    
    [userInfo setObject:errors forKey:NSDetailedErrorsKey];
    
    return [NSError errorWithDomain:NSCocoaErrorDomain
                              code:NSValidationMultipleErrorsError
                          userInfo:userInfo];
}

@end
