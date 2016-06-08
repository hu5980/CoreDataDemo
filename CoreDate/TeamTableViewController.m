//
//  TeamTableViewController.m
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import "TeamTableViewController.h"
#import "CoreDateManage.h"
#import "Player.h"
#import "AddViewController.h"
#import "ChangeViewController.h"

@interface TeamTableViewController ()<NSFetchedResultsControllerDelegate> {
//    NSArray *playerArray;
    NSManagedObjectContext *managedObjectContext;
  }

@property (nonatomic,strong)  NSFetchedResultsController *fetchedResultsController;


@end

@implementation TeamTableViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //可以用这种方法获取数据
 //   playerArray = [[CoreDateManage shareInstance] fetchAllPlayersFromTeamName:_teamName];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    managedObjectContext = appDelegate.managedObjectContext;

    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addPlayerAction)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self fetchedResultsControllerWithTeamName:_teamName];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma --mark Action

- (void)addPlayerAction {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddViewController *addVC = [story instantiateViewControllerWithIdentifier:@"AddViewController"];
    addVC.teamName = _teamName;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
//    return playerArray.count;
    
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerName"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"playerName"];
    }
//    Player *player = [playerArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = player.name  ;
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
         Player *playerObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [[CoreDateManage shareInstance] deletePlayer:playerObject];
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChangeViewController *changeVC = [[ChangeViewController alloc] initWithNibName:@"ChangeViewController" bundle:nil];
    
    Player *playerObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    changeVC.player = playerObject;
    
//  changeVC.player =  [playerArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:changeVC animated:YES];
   
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Player *playerObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = playerObject.name;
    cell.detailTextLabel.text = [playerObject.age stringValue];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


// 通过 NSFetchedResultsController 这个类可以获取数据
- (NSFetchedResultsController *)fetchedResultsControllerWithTeamName:(NSString *) teamName {
    if (nil != _fetchedResultsController) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *playerEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:playerEntity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teamName == %@", teamName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Players"];
    _fetchedResultsController.delegate = self;
    
    [NSFetchedResultsController deleteCacheWithName:nil];
    NSError *error = NULL;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end
