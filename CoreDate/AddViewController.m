//
//  AddViewController.m
//  CoreDate
//
//  Created by 忘、 on 16/6/7.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import "AddViewController.h"
#import "CoreDateManage.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *playerAgeTextField;


@property (weak, nonatomic) IBOutlet UITextField *playerTeamNameTextField;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)addPlayerTargetAction:(UIButton *)sender {
   BOOL insertSuccess =  [[CoreDateManage shareInstance] createPlayEithName:_playerNameTextField.text withPlayerAge:[_playerAgeTextField.text integerValue]withTeamName:_teamName];
    
    if (insertSuccess) {
        NSLog(@"添加成功");
        return;
    }
    
    NSLog(@"添加失败");

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
