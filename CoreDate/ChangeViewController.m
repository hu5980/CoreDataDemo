//
//  ChangeViewController.m
//  CoreDate
//
//  Created by 忘、 on 16/6/8.
//  Copyright © 2016年 xikang. All rights reserved.
//

#import "ChangeViewController.h"
#import "CoreDateManage.h"

@interface ChangeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _nameLabel.text = _player.name;
    _ageTextField.text = [NSString stringWithFormat:@"%@",_player.age];
}

- (IBAction)changePlayerAge:(UIButton *)sender {
    _player.age = [ NSNumber numberWithInteger:[_ageTextField.text integerValue] ];
    
    [[CoreDateManage shareInstance ] updatePlayerInfo:_player];
    
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
