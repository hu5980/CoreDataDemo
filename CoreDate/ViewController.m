//
//  ViewController.m
//  CoreDate
//
//  Created by 忘、 on 16/6/6.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Team.h"
#import "Player.h"
#import "TeamTableViewController.h"
#import "CoreDateManage.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSManagedObjectContext *managedObjectContext;
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    
    [[CoreDateManage shareInstance] createTeamWithName:@"尼克斯" city:@"纽约" menberNum:10];
    [[CoreDateManage shareInstance] createTeamWithName:@"火箭" city:@"休斯敦" menberNum:12];
    
    [[CoreDateManage shareInstance] createPlayEithName:@"科比" withPlayerAge:36 withTeamName:@"火箭"];
    [[CoreDateManage shareInstance] createPlayEithName:@"姚明" withPlayerAge:30 withTeamName:@"火箭"];
    [[CoreDateManage shareInstance] createPlayEithName:@"麦迪" withPlayerAge:38 withTeamName:@"火箭"];

    
    NSArray *teamArray =  [[CoreDateManage shareInstance] fetchListWithEntityName:@"Team"];
    NSArray *playerArray = [[CoreDateManage shareInstance] fetchListWithEntityName:@"Player"];

      // 1.第一种获取
    if (teamArray) {
        for (NSManagedObject *teamObject in teamArray){
            NSString *teamName = [teamObject valueForKey:@"teamName"];
            NSString *teamCity = [teamObject valueForKey:@"teamCity"];
            NSInteger teamMemberNum = [[teamObject valueForKey:@"teamMemberNum"] integerValue];
            NSLog(@"Team info : %@, %@ ,%ld\n", teamName, teamCity,teamMemberNum);
        }
    }
    
    if (playerArray) {
        // 2.第二种获取
        for (Player *player in playerArray) {
            
            NSLog(@"Team info : %@, %ld\n", player.name, [player.age integerValue]);
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma --Mark UItableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[CoreDateManage shareInstance] fetchListWithEntityName:@"Team"].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *teamArray = [[CoreDateManage shareInstance] fetchListWithEntityName:@"Team"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teamCell"];
    }
    Team *team = (Team *) [teamArray objectAtIndex:indexPath.row];
    cell.textLabel.text = team.teamName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamTableViewController *teamVC = [[TeamTableViewController alloc] init];
    NSArray *teamArray = [[CoreDateManage shareInstance] fetchListWithEntityName:@"Team"];
    Team *team = (Team *) [teamArray objectAtIndex:indexPath.row];
    teamVC.teamName = team.teamName;
    [self.navigationController pushViewController:teamVC animated:YES];
}



@end
