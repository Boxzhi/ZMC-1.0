//
//  CommentsVC.m
//  ZMC
//
//  Created by Naive on 16/6/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CommentsVC.h"
#import "CommentListModel.h"
#import "CommentHeadView.h"
#import "CommentCell.h"

#import "UILabel+StringFrame.h"
@interface CommentsVC ()<CYLTableViewPlaceHolderDelegate, WeChatStylePlaceHolderDelegate> {
    
    NSString *status;
    
    CommentListModel *comment_model;
    
    UITableView *_tableView;
    
    CommentHeadView *commentView;
    
    float comment_introHeigh;
    
    float img_heigh;
    
    float comment_childsLabelHeigh;

}

@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    commentView = (CommentHeadView *)[[[NSBundle mainBundle] loadNibNamed:@"CommentHeadView" owner:nil options:nil]lastObject];
    
    [[commentView.allComment_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [commentView.allComment_btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [commentView.allComment_btn setBackgroundColor:ThemeGreenColor];
        [commentView.goodComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.goodComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.midComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.midComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.badComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.badComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.ImgComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.ImgComment_btn setBackgroundColor:WHITE_COLOR];
        
        status = @"1";
        if (self.goods_id) {
            [self getCommentListInfo];
        }else{
            [self getCommentCookListInfo];
        }
        
    }];
    
    [[commentView.goodComment_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [commentView.allComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.allComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.goodComment_btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [commentView.goodComment_btn setBackgroundColor:ThemeGreenColor];
        [commentView.midComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.midComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.badComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.badComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.ImgComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.ImgComment_btn setBackgroundColor:WHITE_COLOR];
        
        status = @"2";
        if (self.goods_id) {
            [self getCommentListInfo];
        }else{
            [self getCommentCookListInfo];
        }
    }];
    
    [[commentView.midComment_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [commentView.allComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.allComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.goodComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.goodComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.midComment_btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [commentView.midComment_btn setBackgroundColor:ThemeGreenColor];
        [commentView.badComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.badComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.ImgComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.ImgComment_btn setBackgroundColor:WHITE_COLOR];
        
        status = @"3";
        if (self.goods_id) {
            [self getCommentListInfo];
        }else{
            [self getCommentCookListInfo];
        }
    }];
    
    [[commentView.badComment_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [commentView.allComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.allComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.goodComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.goodComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.midComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.midComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.badComment_btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [commentView.badComment_btn setBackgroundColor:ThemeGreenColor];
        [commentView.ImgComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.ImgComment_btn setBackgroundColor:WHITE_COLOR];
        
        status = @"4";
        if (self.goods_id) {
            [self getCommentListInfo];
        }else{
            [self getCommentCookListInfo];
        }
    }];
    
    [[commentView.ImgComment_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [commentView.allComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.allComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.goodComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.goodComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.midComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.midComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.badComment_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [commentView.badComment_btn setBackgroundColor:WHITE_COLOR];
        [commentView.ImgComment_btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [commentView.ImgComment_btn setBackgroundColor:ThemeGreenColor];
        
        status = @"5";
        if (self.goods_id) {
            [self getCommentListInfo];
        }else{
            [self getCommentCookListInfo];
        }
    }];
    
    [self.view addSubview:commentView];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    _tableView = [[UITableView alloc] init];
//    _tableView.backgroundColor  = TableViewBColor;
//    self.view.backgroundColor = TableViewBColor;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.refreshTableView = _tableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
    [self setMJrefreshFooter:^{
        [blockSelf loadMoreData];
    }];
    
    status = @"1";
    
    if (self.goods_id) {
        [self getCommentListInfo];
    }else{
        [self getCommentCookListInfo];
    }
    
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    if (self.goods_id) {
        [self getCommentListInfo];
    }else{
        [self getCommentCookListInfo];
    }

    
}

- (void)loadMoreData{
    
    self.currentPage = self.currentPage + 1;
    if (self.goods_id) {
        [self getCommentListInfo];
    }else{
        [self getCommentCookListInfo];
    }

    
}


- (void)getCommentCookListInfo {
    
    [CommonHttpAPI getCommentCookListWithEspecId:[NSString stringWithFormat:@"/%@",self.cook_id]  WithParameters:[CommonRequestModel getCommentCookListWithPageNO:ChangeNSIntegerToStr(self.currentPage) page_size:@"15" status:status] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            if (self.currentPage == 1) {
                [self.totalDataAry removeAllObjects];
            }
            
            comment_model = [CommentListModel mj_objectWithKeyValues:responseObject];
            
            [commentView.allComment_btn setTitle:[NSString stringWithFormat:@"全部(%ld)",(long)comment_model.result.total_num] forState:UIControlStateNormal];
            [commentView.goodComment_btn setTitle:[NSString stringWithFormat:@"好评(%ld)",(long)comment_model.result.good_num] forState:UIControlStateNormal];
            [commentView.midComment_btn setTitle:[NSString stringWithFormat:@"中评(%ld)",(long)comment_model.result.moderate_num] forState:UIControlStateNormal];
            [commentView.badComment_btn setTitle:[NSString stringWithFormat:@"差评(%ld)",(long)comment_model.result.negative_num] forState:UIControlStateNormal];
            [commentView.ImgComment_btn setTitle:[NSString stringWithFormat:@"带图(%ld)",(long)comment_model.result.bask_num] forState:UIControlStateNormal];
            
            [comment_model.result.data enumerateObjectsUsingBlock:^(CommentListData *obj, NSUInteger idx, BOOL *stop) {
                
                [self.totalDataAry addObject:obj];
            }];
            
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
            if (self.currentPage >= comment_model.result.total_pages) {
                
                [self hidenFooterView];
                
            }
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         ZMCLog(@"%@",error);
    }];
}

- (void)getCommentListInfo {
    
    [CommonHttpAPI getCommentListWithEspecId:[NSString stringWithFormat:@"/%@",self.goods_id] WithParameters:[CommonRequestModel getCommentListWithPageNO:ChangeNSIntegerToStr(self.currentPage) page_size:@"15" status:status] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        comment_model = [CommentListModel mj_objectWithKeyValues:responseObject];
        
        [commentView.allComment_btn setTitle:[NSString stringWithFormat:@"全部(%ld)",(long)comment_model.result.total_num] forState:UIControlStateNormal];
        [commentView.goodComment_btn setTitle:[NSString stringWithFormat:@"好评(%ld)",(long)comment_model.result.good_num] forState:UIControlStateNormal];
        [commentView.midComment_btn setTitle:[NSString stringWithFormat:@"中评(%ld)",(long)comment_model.result.moderate_num] forState:UIControlStateNormal];
        [commentView.badComment_btn setTitle:[NSString stringWithFormat:@"差评(%ld)",(long)comment_model.result.negative_num] forState:UIControlStateNormal];
        [commentView.ImgComment_btn setTitle:[NSString stringWithFormat:@"带图(%ld)",(long)comment_model.result.bask_num] forState:UIControlStateNormal];
        if ([responseObject getTheResultForDic]) {
            
            if (self.currentPage == 1) {
                [self.totalDataAry removeAllObjects];
            }
            
            [comment_model.result.data enumerateObjectsUsingBlock:^(CommentListData *obj, NSUInteger idx, BOOL *stop) {
                
                [self.totalDataAry addObject:obj];
            }];
            
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
            if (self.currentPage >= comment_model.result.total_pages) {
                
                [self hidenFooterView];
                
            }
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
//        [self.refreshTableView cyl_reloadData];
        [self endRefresh];
    }];
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.refreshTableView.frame];
    weChatStylePlaceHolder.delegate = self;
    
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"暂无评价";
//    weChatStylePlaceHolder.content = @"快去评论吧!";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
//    [self beginFresh];
}

- (void)getLabelHeigh:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = text;
    label.numberOfLines = 0;
    CGSize size = [label boundingRectWithSize:CGSizeMake(SCREEN_W-26, label.frame.size.height)];
    comment_introHeigh = size.height;
//    comment_childsLabelHeigh = comment_childsLabelHeigh + size.height;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.totalDataAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self getLabelHeigh:((CommentListData *)self.totalDataAry[indexPath.section]).content];
    float heigh = comment_introHeigh;
    [self getLabelHeigh:((CommentListData *)self.totalDataAry[indexPath.section]).result];
    if (comment_model.result.data[indexPath.section].picList.count != 0) {
        img_heigh = 76;
    }else {
        img_heigh = 0;
    }
    return 120+comment_introHeigh+img_heigh+heigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    static NSString *identifier = @"CommentCell";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] firstObject];
    }
    [cell setCommentList:self.totalDataAry[indexPath.section]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
