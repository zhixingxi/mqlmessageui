//
//  ViewController.m
//  QLTextMessage
//
//  Created by MQL-IT on 2017/5/21.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "QLMessageController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击进入消息页面" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.center.equalTo(self.view);
    }];
}
- (void)btnClick:(UIButton *)sender {
    QLMessageController *vc = [[QLMessageController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
