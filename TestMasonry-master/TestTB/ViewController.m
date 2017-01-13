//
//  ViewController.m
//  TestTB
//
//  Created by Damon on 16/8/18.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"
#import "DTestCell.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic, strong) UITableView * listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.listView reloadData];
}
- (UITableView *)listView{
    if(!_listView){
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 420, 600) style:UITableViewStyleGrouped];
        _listView.delegate = self;
        _listView.dataSource = self;
        [self.view addSubview:_listView];
    }
    return _listView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell){
        cell = [[DTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
