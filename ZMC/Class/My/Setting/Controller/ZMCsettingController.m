//
//  ZMCsettingController.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCsettingController.h"
#import "ZMCInputView.h"
#import <Masonry.h>
#import "ZMCAddressViewController.h"
#import "ZMCMyTableViewController.h"
#import "ZMCSettingItem.h"
#import "ZMCCustomeTabBarController.h"
#import "ZMCImageAmp.h"



@interface ZMCsettingController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIView *foottView;
// 头像View
@property (nonatomic, weak) UIImageView *heardImageView;

@property (nonatomic, strong) NSArray *input;


// 保存头像的URL
@property (nonatomic, strong) NSString *urlStr;
// 昵称
@property (nonatomic, weak) UITextField *nameField;
// 签名
@property (nonatomic, weak) UITextField *sigField;

@end

@implementation ZMCsettingController
    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(save) title:@"保存"];
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    
    [self setContentView];
    [self initView];
    
}



#pragma mark - contentView
- (void)setContentView{
    
    // 顶部View
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.left.right.equalTo(self.view);
          make.height.mas_equalTo(80);
    }];
    
    // 头像View
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = self.avatar;
    self.heardImageView = imageView;
    imageView.layer.cornerRadius = 32.5;
    imageView.layer.masksToBounds = YES;
    [headView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left).offset(10);
        make.centerY.equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    
    // 更换头像按钮
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setTitle:@"更换头像" forState:UIControlStateNormal];
    [imageBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    imageBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [imageBtn addTarget:self action:@selector(replaceButton) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:imageBtn];
    [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView.mas_right).offset(-10);
        make.centerY.equalTo(headView);
    }];
    
    
    // 昵称/个性签名
    ZMCInputView *inputView = [ZMCInputView InputView];
    inputView.nameField.text = self.nick_name;
    inputView.autographField.text = self.signature;
    inputView.nameField.delegate = self;
    inputView.autographField.delegate = self;
    [inputView.nameField addTarget:self action:@selector(fieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _nameField = inputView.nameField;
    _sigField = inputView.autographField;
    [self.view addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
    }];
    
    // 收货地址
    UIView *fView = [[UIView alloc] init];
    self.foottView = fView;
    [self.view addSubview:fView];
    [fView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(inputView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    // 退出登录
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(fView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
}


- (void)tapAction{
    
    [ZMCImageAmp showImage:self.heardImageView];
    
}

#pragma mark - 退出登录
- (void)exit{
    [USER_DEFAULT removeObjectForKey:@"access_token"];
    [USER_DEFAULT removeObjectForKey:@"refresh_token"];
    [USER_DEFAULT removeObjectForKey:@"expire_time"];
    [USER_DEFAULT removeObjectForKey:@"login_time"];

    [HYBNetworking clearCaches];
    
    [USER_DEFAULT setObject:@"0" forKey:ISLOGIN];
    [self.navigationController popViewControllerAnimated:YES];

    /**
     *  跳转到APP Store更新版本
     */
//    [self onCheckVesion];
}


//-(void)onCheckVesion{
////    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    //CFShow((__bridge CFTypeRef)(infoDic));
////    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
//    
//    NSLog(@"当前版本的版本号----%@",CLIENT_VERSION);
//    //如果是第一个版本,则直接返回
//    if ([CLIENT_VERSION isEqualToString:@"1"]) {
////        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" contentText:@"已是最新版本" leftButtonTitle:@"知道了" rightButtonTitle:@"取消"];
////        [alert show];
//        return;
//    }
//    NSString *URL = @"http://itunes.apple.com/lookup?id=1125326330";//在商店里面的appid
//    [HYBNetworking postWithUrl:URL refreshCache:NO params:nil success:^(id response) {
//        NSDictionary *dic = response;
//        NSArray *infoArray = [dic objectForKey:@"results"];
//        if ([infoArray count]) {
//            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
//            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
//            NSLog(@"appstore上面的版本号是-----%@",lastVersion);
//            NSString *trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
//            NSLog(@"----trackviewURL === %@",trackViewURL);
//            if (![lastVersion isEqualToString:CLIENT_VERSION]) {
//                //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
//                alert.tag = 10000;
//                [alert show];
//            }
//            else
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                alert.tag = 10001;
//                [alert show];
//            }
//        }
//
//    } fail:^(NSError *error) {
//         ZMCLog(@"%@",error);
//    }];
//}
////更新按钮的点击事件
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==10000) {
//        if (buttonIndex==1) {
//            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/zen-me-chi/id1125326330?l=zh&ls=1&mt=8"];
//            [[UIApplication sharedApplication]openURL:url];
//        }
//    }
//}


#pragma mark - 更换头像按钮
- (void)replaceButton{
    ZMCFunc;
    // 选择照片控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:nil];
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:nil];
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVc addAction:cameraAction];
    [alertVc addAction:photoLibraryAction];
    [alertVc addAction:cancelAction];
    
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

// 换上选中的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.heardImageView.image = info[UIImagePickerControllerEditedImage];
    
}



// 设置UIImagePickerView的导航条文字颜色
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}



#pragma mark - 底部View
- (void)initView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.foottView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.foottView);
    }];
}


#pragma mark - 最后一行cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"footcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"收货地址";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
    
}

#pragma mark - 点击收货地址
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMCAddressViewController *addressVc = [[ZMCAddressViewController alloc] init];
    
    [self.navigationController pushViewController:addressVc animated:YES];
   
}

#pragma mark - 设置界面的保存按钮
- (void)save{
    
    if (_nameField.text == NULL || [_nameField.text isEqualToString:@""]) {
        [OMGToast showWithText:@"用户名不能为空"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在保存..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

    NSString *url = @"http://115.159.227.219:8088/fanfou-api/upload";
    
    [HYBNetworking uploadWithImage:_heardImageView.image url:url filename:@"myImage.jpg" name:@"avatar_url" mimeType:@"image/jpeg" parameters:nil progress:nil success:^(id response) {
        ZMCLog(@"图片上传信息---->%@", response);
        if (response[@"result"][0][@"url"] == nil) {
            [SVProgressHUD showErrorWithStatus:@"保存失败，请重新保存"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            
            self.urlStr = response[@"result"][0][@"url"];
            
            if (self.urlStr) {
                
                [ZMCSettingItem setavatar_url:self.urlStr nick_name:[NSString stringWithFormat:@"%@", _nameField.text] signature:[NSString stringWithFormat:@"%@", _sigField.text]];
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
//                ZMCCustomeTabBarController *tabbar = [[ZMCCustomeTabBarController alloc] init];
//                tabbar.selectedIndex = 0;
      
                [SVProgressHUD dismiss];
            }
        }
        
    } fail:^(NSError *error) {
        ZMCLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _nameField) {
        [_sigField becomeFirstResponder];
    }else if (textField == self.sigField){
        [self.view endEditing:YES];
    }
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)fieldDidChange:(UITextField *)textField{
    if (textField == _nameField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}


@end
