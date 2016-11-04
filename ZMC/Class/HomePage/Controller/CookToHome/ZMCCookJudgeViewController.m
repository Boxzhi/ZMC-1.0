//
//  ZMCCookJudgeViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCookJudgeViewController.h"
#import "ZMCCommentImageTableViewCell.h"
#import "ZMCCommentTableViewCell.h"

@interface ZMCCookJudgeViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *_judgeArray;
    
    UIButton *_selectButton;
}
@end

static NSString *cellReuseId = @"commentCell";
static NSString *imageCellReuseId = @"CommentImageCell";
@implementation ZMCCookJudgeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _judgeArray = @[@"好评",@"中评",@"差评",@"带图"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"评价";
    
    UITableView *judgeTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    judgeTableView.delegate = self;
    judgeTableView.dataSource = self;
    judgeTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self.view addSubview:judgeTableView];
    judgeTableView.tableHeaderView = [self getJudegTableHeader];
    [judgeTableView registerNib:[UINib nibWithNibName:@"ZMCCommentTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    [judgeTableView registerNib:[UINib nibWithNibName:@"ZMCCommentImageTableViewCell" bundle:nil] forCellReuseIdentifier:imageCellReuseId];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 5? 260:160;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    根据返回的评论内容是否含有图片，来加载不同的cell
    if (indexPath.row >5) {
        ZMCCommentImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellReuseId forIndexPath:indexPath];
        return cell;
    }
    ZMCCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    return cell;
}

#pragma mark- 设置表头的四个按钮
- (UIView *)getJudegTableHeader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    CGFloat positonX = 10;
    for (int i = 0; i <4; i ++) {
        UIButton *judgeButton = [[UIButton alloc] init];
        judgeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [judgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [judgeButton setTitleColor:StringMiddleColor forState:UIControlStateNormal];
        judgeButton.tag = i;
        judgeButton.backgroundColor = [UIColor whiteColor];
        [judgeButton setTitle:_judgeArray[i] forState:UIControlStateNormal];
        judgeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        judgeButton.layer.cornerRadius = 4;
        judgeButton.layer.masksToBounds = YES;
        [view addSubview:judgeButton];
        [judgeButton addTarget:self action:@selector(clickToChangeJudge:) forControlEvents:UIControlEventTouchUpInside];
        [judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(positonX);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(70, 30));
        }];
        positonX = positonX + 70 +10;
        
        if (i == 0) {
            _selectButton = judgeButton;
            _selectButton.selected = YES;
            _selectButton.backgroundColor = ThemeGreenColor;
        }
    }
    return view;
}

#pragma mark- 点击表头中的四个按钮，筛选不同类型的评价
- (void)clickToChangeJudge:(UIButton *)button
{
    _selectButton.selected = NO;
    _selectButton.backgroundColor = [UIColor whiteColor];
    button.selected = YES;
    button.backgroundColor = ThemeGreenColor;
    _selectButton = button;
    
    
}


@end
