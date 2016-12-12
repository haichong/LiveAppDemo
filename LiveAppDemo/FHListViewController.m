//
//  FHListViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 16/9/30.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHListViewController.h"
#import <AFNetworking.h>
#import "FHLiveViewController.h"
#import "FHLiveTableViewCell.h"
#import "FHLiveModel.h"

@interface FHListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong,nonatomic) NSMutableArray *lives;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation FHListViewController

-(NSMutableArray *)lives{
    
    if (!_lives) {
        _lives = [NSMutableArray new];
    }
    return _lives;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setHidden:NO];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *lives = responseObject[@"lives"];
        [self.lives removeAllObjects];
        for (NSDictionary *dic in lives) {
            FHLiveModel *playerModel = [[FHLiveModel alloc] initWithDictionary:dic];
            playerModel.city = dic[@"city"];
            playerModel.portrait = dic[@"creator"][@"portrait"];
            playerModel.name = dic[@"creator"][@"nick"];
            playerModel.online_users = [dic[@"online_users"] intValue];
            playerModel.url = dic[@"stream_addr"];
            [self.lives addObject:playerModel];
            
        }
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    [self.tableview registerNib:[UINib nibWithNibName:@"FHLiveTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FHLiveTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lives.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UIScreen mainScreen].bounds.size.width * 618/480 + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FHLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FHLiveTableViewCell" forIndexPath:indexPath];
    FHLiveModel *model = self.lives[indexPath.row];
    [cell  setPlayerModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FHLiveModel *model = self.lives[indexPath.row];
    FHLiveViewController *liveVC = [FHLiveViewController new];
    liveVC.imageUrl = model.portrait;
    liveVC.liveUrl = model.url;
    [self.navigationController pushViewController:liveVC animated:YES];
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
