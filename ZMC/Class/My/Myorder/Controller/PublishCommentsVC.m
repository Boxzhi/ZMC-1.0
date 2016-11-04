//
//  PublishCommentsVC.m
//  ZMC
//
//  Created by Naive on 16/6/2.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "PublishCommentsVC.h"
#import "PublishCommentsCell.h"

#import "ImageInfoModel.h"

@interface PublishCommentsVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIActionSheetDelegate>{
    
    PublishCommentsCell *cell;
    
    UITableView *_tableView;
    
    NSMutableArray *labelsArr;
    
    NSMutableArray *imgArr;
    
    int score;
    
    int tag;
}
- (IBAction)publishCommentsBtn:(UIButton *)sender;

@end

@implementation PublishCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表评论";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-104)];
//    _tableView.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    labelsArr = [NSMutableArray array];
    imgArr = [NSMutableArray array];
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 600;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    static NSString *identifier = @"PublishCommentsCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PublishCommentsCell" owner:nil options:nil] firstObject];
    }
    
    cell.commentTextView.inputAccessoryView = [self addToolbar];
    
    [cell.goodsImg sd_setImageWithURL:GET_IMAGEURL_URL(self.goodsImg) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
    cell.goodsName_lab.text = self.goodsName;
    
    cell.goodsTime_lab.text = self.goodsTime;
    
    [cell.commentTextView.layer setBorderWidth:1.0];
    [cell.commentTextView.layer setCornerRadius:5.0f];
    [cell.commentTextView.layer setBorderColor:[[UIColor colorWithWhite:0.6 alpha:0.6]CGColor]];
    cell.commentTextView.delegate = self;
    if ([_is_cook isEqualToString:@"1"]) {
        cell.comments_lab.text = @"大厨评分";
        cell.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:self.goodsPrice unit:@"" unitName:self.goodsUnit leftColor:ThemeGreenColor rightClor:nil];
        cell.goodsTime_lab.text = self.goodsTime;
    }else {
        cell.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:self.goodsPrice unit:self.goodsUnit unitName:self.goodsUnitName leftColor:ThemeGreenColor rightClor:nil];
    }
    
    [[cell.starBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        cell.starImgView.image = [UIImage imageNamed:@"star_one"];
        score = 2;
    }];
    [[cell.starBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        cell.starImgView.image = [UIImage imageNamed:@"star_two"];
        score = 4;
    }];
    [[cell.starBtn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        cell.starImgView.image = [UIImage imageNamed:@"star_three"];
        score = 6;
    }];
    [[cell.starBtn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        cell.starImgView.image = [UIImage imageNamed:@"star_four"];
        score = 8;
    }];
    [[cell.starBtn5 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        cell.starImgView.image = [UIImage imageNamed:@"star_full"];
        score = 10;
    }];
    
    [[cell.photoBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [cell.commentTextView resignFirstResponder];
        [self whenClickHeadImage];
        tag = 1;
    }];
    [[cell.photoBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [cell.commentTextView resignFirstResponder];
        [self whenClickHeadImage];
        tag = 2;
    }];
    [[cell.photoBtn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [cell.commentTextView resignFirstResponder];
        [self whenClickHeadImage];
        tag = 3;
    }];
    [[cell.photoBtn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [cell.commentTextView resignFirstResponder];
        [self whenClickHeadImage];
        tag = 4;
    }];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - 选择头像
-(void)whenClickHeadImage{
    
    UIActionSheet *sheet;
    sheet = [[UIActionSheet alloc] initWithTitle:@"亲，您可以上传4张图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    sheet.tag = 255;
    sheet.actionSheetStyle = UIBarStyleBlackOpaque;
    [sheet showInView:self.view];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:tag];
    [btn setImage:image forState:UIControlStateNormal];
    if (tag<5) {
        UIButton *btn1 = (UIButton *)[cell.contentView viewWithTag:tag+1];
        btn1.hidden  = NO;
    }
    
    [imgArr addObject:image];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - PickerController delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        switch (buttonIndex) {
            case 1:
                // 相册  或者 UIImagePickerControllerSourceTypePhotoLibrary
                sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                ZMCLog(@"选择相册图片");
                break;
                //相机
            case 0:
            {
                sourceType = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Test on real device, camera is not available in simulator" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alert show];
                    return;
                }
            }
                break;
            case 2:
                ZMCLog(@"取消");
                // 取消
                return;
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate =self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([cell.commentTextView.text isEqualToString:@"请写下对商品的评价，对他人帮助很大哦！"]) {
        cell.commentTextView.text = @"";
        cell.commentTextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([cell.commentTextView.text isEqualToString:@""]) {
        cell.commentTextView.text = @"请写下对商品的评价，对他人帮助很大哦！";
        cell.commentTextView.textColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    }
}

- (IBAction)publishCommentsBtn:(UIButton *)sender {
    
    if (score == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请给商品评分"];
        
    }else if ([cell.commentTextView.text isEqualToString:@"请写下对商品的评价，对他人帮助很大哦！"] || [cell.commentTextView.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"反馈内容不能为空"];
        
    }else {
        if (imgArr.count == 0) {
            [self getComment:@""];
        }else{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [SVProgressHUD showWithStatus:@"正在提交"];
            [manager POST:[NSString stringWithFormat:@"%@/fanfou-api/upload",ReleaseHost] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                for (int i=0;i<imgArr.count;i++) {
                    [formData appendPartWithFileData:UIImageJPEGRepresentation([imgArr objectAtIndex:i],0.5) name:[NSString stringWithFormat:@"file%d",i ] fileName:[NSString stringWithFormat:@"pic%d.jpg",i] mimeType:@"image/jpeg"];
                }

            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    ImageInfoModel *model = [ImageInfoModel mj_objectWithKeyValues:dic];
                    ZMCLog(@"%@",dic);
                    if ([dic getTheResultForDic]) {
                        NSMutableString *pics = [[NSMutableString alloc] init];
                        [model.result enumerateObjectsUsingBlock:^(ImageInfoResult *obj, NSUInteger idx, BOOL *stop) {
                            [pics appendString:[NSString stringWithFormat:@"%@,",obj.url]];
                        }];
                        NSString *str = [pics substringToIndex:[pics length] - 1];
                        ZMCLog(@"%@",str);
                        [self getComment:str];
                    }else {
                        [SVProgressHUD showErrorWithStatus:[dic getResultMessage]];
                    }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                ZMCLog(@"%@",error.localizedDescription);
            }];
        }
        
        
    }
}

- (void)getComment:(NSString *)str {
    
    NSMutableArray *arrLabel = [NSMutableArray array];
    for (int i=0; i<labelsArr.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:labelsArr[i] forKey:@"id"];
        [arrLabel addObject:dic];
    }
    if ([_is_cook isEqualToString:@"1"]) {
        
        
        [CommonHttpAPI postCommentCookAddWithParameters:[CommonRequestModel getommentCookAddInfoWithContent:cell.commentTextView.text WithCookID:self.goods_id WithLabels:arrLabel WithParentID:@"0" WithPics:str WithScore:ChangeNSIntegerToStr(score) WithOrderID:self.order_id] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            [SVProgressHUD dismiss];
            if ([responseObject getTheResultForDic]) {
                
                [SVProgressHUD showSuccessWithStatus:@"评论已提交"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
        
    }else {
        [CommonHttpAPI postCommentAddWithParameters:[CommonRequestModel getommentAddInfoWithContent:cell.commentTextView.text WithGoodsID:self.goods_id WithLabels:arrLabel WithParentID:@"0" WithPics:str WithScore:ChangeNSIntegerToStr(score) WithOrderID:self.order_id] success:^(NSURLSessionDataTask *task, id responseObject) {
            ZMCLog(@"%@",responseObject);
            [SVProgressHUD dismiss];
            if ([responseObject getTheResultForDic]) {
                
                [SVProgressHUD showSuccessWithStatus:@"评论已提交"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
    }
    
    
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    [bar setTintColor:[UIColor blackColor]];
    toolbar.items = @[nextButton, prevButton, space, bar];
    return toolbar;
}

- (void)textFieldDone{
    [cell.commentTextView resignFirstResponder];
}
@end
