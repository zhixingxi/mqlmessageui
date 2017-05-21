//
//  QLMessageController.m
//  QLTextMessage
//
//  Created by MQL-IT on 2017/5/21.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//


#import "QLMessageController.h"
#import "QLTextMessageCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "MessageModel.h"

#define SDScreenWidth [UIScreen mainScreen].bounds.size.width
#define SDScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *const cellID = @"QLTextMessageCell";

@interface QLMessageController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mytableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation QLMessageController

- (void)dealloc {
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *message = @"我是一条消息";
    
    for (int i = 0; i < 20; i++) {
        NSInteger num = (arc4random() % 20) + 1;
        NSMutableString *str = [@"" mutableCopy];
        NSLog(@"%@", [NSThread currentThread]);
        for (int i = 0; i < num; i++) {
            [str appendString:message];
        }
        MessageModel *model = [[MessageModel alloc]init];
        model.textContent = str;
        [self.dataArray addObject:model];
 
    }

    
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"消息";
    
    [self.view addSubview:self.mytableView];
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QLTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    MessageModel *model = self.dataArray[indexPath.row];
    cell.messageModel = model;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellID cacheByIndexPath:indexPath configuration:^(QLTextMessageCell* cell) {
        cell.messageModel = self.dataArray[indexPath.row];
    }];
}

#pragma mark - getters

- (UITableView *)mytableView {
    
    if (!_mytableView) {
        _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SDScreenWidth, SDScreenHeight) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        //注册cell尽量排在前面, 不然可能会注册失败
        [_mytableView registerClass:[QLTextMessageCell class] forCellReuseIdentifier:cellID];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1];
        _mytableView.tableFooterView = [[UIView alloc]init];
    }
    return _mytableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
