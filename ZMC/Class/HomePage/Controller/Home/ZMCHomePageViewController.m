//
//  ZMCHomePageViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "ZMCHomePageViewController.h"
#import <UIImageView+WebCache.h>
#import <SDCycleScrollView.h>

#import "HomeMarketCell.h"
#import "ZMCSpecialTableViewCell.h"
#import "ZMCAdsTableViewCell.h"
#import "ZMCSpecialViewController.h"
#import "ZMCSearchViewController.h"
#import "ZMCLocationViewController.h"
#import "ZMCCookToHomeViewController.h"
#import "ZMCActivityViewController.h"
#import "ZMCMyintegralViewController.h"
#import "ZMCMyorderViewController.h"

#import <CoreLocation/CoreLocation.h>

#import "LocationMarketModel.h"
#import "HomeLocationItem.h"
#import "HomeNetwork.h"
#import "CarouselsModel.h"
#import "SpecialGoodsModel.h"
#import "HotGoodsModel.h"
#import "HomeModel.h"
#import "NearbyMerchantModel.h"

#import "ZMCSearchResultViewController.h"

#import <MJRefresh.h>

#import "GoodsDetailVC.h"
#import "ZMCPayViewController.h"
#import "ZMCCookBookDetailViewController.h"
#import "GuidePageView.h"


#import "ZMCRegisterViewController.h"
#import "LZFoldButton.h"

#import "ZMCRefreshHeader.h"
#import "ShopsDetailVC.h"



#define VERSION_INFO_CURRENT @"currentversion"
#define isUpdate @"update"

@interface ZMCHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,CLLocationManagerDelegate>

{
    UIScrollView *_topScrollView;
    NSArray *_bannerModelArray;

    NSArray *_buttonImageArray;
    NSArray *_buttonTitleArray;
    
    HomeModel *_homeModel;
    

}

@property (nonatomic, strong) UITableView *mainTableView;

@property (strong, nonatomic) CLLocationManager* locationManager;

@property (nonatomic, strong) NSString *provincesStr;
@property (nonatomic, strong) NSString *cityStr;
@property (nonatomic, strong) NSString *countyStr;
@property (nonatomic, strong) NSString *street;
@end

static NSString *cellReuseId = @"cell";
static NSString *adCellReuseId = @"ads";
static NSString *marketCellReuseId = @"HomeMarketCell";

@implementation ZMCHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationItem.titleView = [self locationInfoView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

    if ([[USER_DEFAULT objectForKey:@"isUpdate"] isEqualToString:@"YES"]) {
        [self onCheckVesion];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startLocationService];

    _buttonImageArray = @[@"activity",@"cook",@"order",@"sign"];
    _buttonTitleArray = @[@"活动",@"大厨到家",@"订单",@"签到积分"];

    self.navigationItem.titleView = [self locationInfoView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(clickToSearch) title:nil];
    [self.view addSubview:self.mainTableView];
    
    [self addObserver:self forKeyPath:@"locationModel" options:NSKeyValueObservingOptionNew context:nil];
    
}


#pragma mark -
-(void)onCheckVesion{

    ZMCLog(@"当前版本的版本号----%@",CLIENT_VERSION);
    //如果是第一个版本,则直接返回
    if ([CLIENT_VERSION isEqualToString:@"1.0"]) {

        return;
    }
    NSString *URL = @"http://itunes.apple.com/lookup?id=1125326330";//在商店里面的appid
    [HYBNetworking postWithUrl:URL refreshCache:NO params:nil success:^(id response) {
        NSDictionary *dic = response;
        NSArray *infoArray = [dic objectForKey:@"results"];
        if ([infoArray count]) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            ZMCLog(@"appstore上面的版本号是-----%@",lastVersion);
            NSString *trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            ZMCLog(@"----trackviewURL === %@",trackViewURL);
            NSString *lastVersionFirst = [lastVersion substringToIndex:3];
            NSString *lastVersionLast = [lastVersion substringWithRange:NSMakeRange(2, 3)];
            NSString *currentVersionFirst = [CLIENT_VERSION substringToIndex:3];
            NSString *currentVersionLast = [CLIENT_VERSION substringWithRange:NSMakeRange(2, 3)];
            ZMCLog(@"AppStore版本->>%@-%@-------%@-%@", lastVersionFirst, lastVersionLast, currentVersionFirst, currentVersionLast);
            
            
            if (lastVersionFirst < currentVersionFirst) {
                return ;
            }else if (lastVersionFirst == currentVersionFirst){
                if (lastVersionLast <= currentVersionLast) {
                    return;
                }else{
                    ZMCLog(@"需要更新");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"有新的版本可更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"立即更新", nil];
                    alert.tag = 10000;
                    [alert show];
                    
                    [USER_DEFAULT setObject:@"NO" forKey:@"isUpdate"];
                    [USER_DEFAULT synchronize];
                }
            }else if (lastVersionFirst > currentVersionFirst){
                ZMCLog(@"需要更新");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"有新的版本可更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"立即更新", nil];
                alert.tag = 10000;
                [alert show];
                
                [USER_DEFAULT setObject:@"NO" forKey:@"isUpdate"];
                [USER_DEFAULT synchronize];
            }
            
            
//            if (lastVersionFirst <= currentVersionFirst) {
//                if (lastVersionLast > currentVersionLast){
//                    
//                    ZMCLog(@"需要更新");
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"有新的版本可更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"立即更新", nil];
//                    alert.tag = 10000;
//                    [alert show];
//                    
//                    [USER_DEFAULT setObject:@"NO" forKey:@"isUpdate"];
//                    [USER_DEFAULT synchronize];
//                }
//            }else {
//                ZMCLog(@"需要更新");
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"有新的版本可更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"立即更新", nil];
//                alert.tag = 10000;
//                [alert show];
//                
//                [USER_DEFAULT setObject:@"NO" forKey:@"isUpdate"];
//                [USER_DEFAULT synchronize];
//            }
        }

    } fail:^(NSError *error) {
         ZMCLog(@"%@",error);
    }];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/zen-me-chi/id1125326330?l=zh&ls=1&mt=8"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self sendRequest];

}


//根据菜场id发送请求，定位或搜索界面返回之后，用新的id重新发送
- (void)sendRequest
{

    if (!_locationModel && _markets.count) {
        _locationModel = _markets[0];
    }
    
    [USER_DEFAULT setObject:_locationModel.name forKey:@"market_name"];
    [USER_DEFAULT setObject:ChangeNSIntegerToStr(_locationModel.ID) forKey:@"market_id"];
    [USER_DEFAULT synchronize];
    
    ZMCLog(@"Market_id%@",Market_id);

    self.navigationItem.titleView = [self locationInfoView];
    
    __weak typeof(self) weakSelf = self;
    
    [CommonHttpAPI getHomeMainWithParameters:[CommonRequestModel getHomeMainWithMarketId:Market_id] success:^(NSURLSessionDataTask *task, id responseObject) {
    
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            _homeModel = [HomeModel mj_objectWithKeyValues:responseObject[@"result"]];
            [NearbyMerchantModel  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"ID":@"id"};
            }];
            
            _mainTableView.tableHeaderView = [weakSelf getHeaderView];
            [_mainTableView reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
        [_mainTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
        

        [_mainTableView.mj_header endRefreshing];
    }];

    
    
}


#pragma mark - 开始定位
- (void)startLocationService
{
    
    if (![CLLocationManager locationServicesEnabled]) {
        ALERT_MSG(@"无法进行定位", @"请检查你的设备是否开启定位服务");
        return;
    }
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }else
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 10.0;//五十米定位一次
        self.locationManager.distanceFilter = distance;
        //启动跟踪定位
        [self.locationManager startUpdatingLocation];
    }
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
    {
        [_locationManager requestWhenInUseAuthorization];// 前台定位
        [_locationManager requestAlwaysAuthorization];// 前后台同时定位
    }
    
}

////开始定位
//-(void)startLocation{
//    
//    if (nil == _locationManager)
//        
//        _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    //设置定位的精度
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    //设置移动多少距离后,触发代理.
//    _locationManager.distanceFilter = 10;
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
//    {
//        [_locationManager requestWhenInUseAuthorization];// 前台定位
//        [_locationManager requestAlwaysAuthorization];// 前后台同时定位
//    }
//}
//


//// 错误信息
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    ZMCLog(@"error%@",error);
//}
// 6.0 以上调用这个函数
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    
//    CLLocation *newLocation = locations[0];
//    //    ZMCLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
//    
//    //    CLLocation *newLocation = locations[1];
//    //    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
//    //    ZMCLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
//    
//    // 计算两个坐标距离
//    //    float distance = [newLocation distanceFromLocation:oldLocation];
//    //    ZMCLog(@"%f",distance);
//    
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation:newLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error){
//                       
//                       ZMCLog(@"%@",error);
//                       
//                       for (CLPlacemark *place in placemarks) {
//                           
////                           label.text = place.name;
//                           ZMCLog(@"name============%@",place.name);//位置名
//                           ZMCLog(@"街道======%@",place.thoroughfare);// 街道
//                           ZMCLog(@"子街道======%@",place.subThoroughfare);//子街道
//                           ZMCLog(@"市======%@",place.locality);//市
//                           ZMCLog(@"区======%@",place.subLocality);//区
//                           ZMCLog(@"国家======%@",place.country);//国家
//                           
//                       }
//                   }];
//}




- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    return _locationManager;
}


#pragma mark- 加载maintableview
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -49 -64) style:UITableViewStylePlain];
        _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //隐藏分割线
        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [_mainTableView registerNib:[UINib nibWithNibName:@"ZMCSpecialTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
        [_mainTableView registerNib:[UINib nibWithNibName:@"ZMCAdsTableViewCell" bundle:nil] forCellReuseIdentifier:adCellReuseId];
        [_mainTableView registerNib:[UINib nibWithNibName:@"HomeMarketCell" bundle:nil] forCellReuseIdentifier:marketCellReuseId];
        
        _mainTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _mainTableView.tableHeaderView = [self getHeaderView];
        

        _mainTableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
//        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [self sendRequest];
//        }];
    }
    
    return _mainTableView;
}


#pragma mark- 导航栏中间的view
- (UIView *)locationInfoView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16*6+10+15+60, 30)];
//    view.backgroundColor = [UIColor blackColor];
    
    UIImageView *locationImage = [[UIImageView alloc] init];
    locationImage.image = [UIImage imageNamed:@"nav_GPS"];
    [view addSubview:locationImage];
//    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view);
//        make.centerY.equalTo(view);
//        make.width.mas_equalTo(11);
//        make.height.mas_equalTo(16);
//    }];
    
    
    UIButton *locationButton = [[UIButton alloc] init];
    NSString *buttonName;
//从请求回来的数据中找定位的位置信息
    buttonName = [USER_DEFAULT objectForKey:@"HomeLocation"];
//    if (_locationModel) { 
////        buttonName = _locationModel.name;
//
//        buttonName = [USER_DEFAULT objectForKey:@"HomeLocation"];
//    } else {
//
////        buttonName = @"点击搜索菜场";
//    }
    locationButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [locationButton setTitle:buttonName forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(clickToLocate) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:locationButton];
//    locationButton.backgroundColor = RedColor;
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view);
        make.right.equalTo(locationButton.mas_left).offset(-6);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(16);
    }];
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImage.mas_right).with.offset(6);
        make.top.equalTo(view);
//        make.right.equalTo(view);
        make.centerX.equalTo(view);
//        make.width.mas_equalTo(16*6+15+60);
        make.height.mas_equalTo(30);
    }];
    
    return view;
}

#pragma mark- 点击跳转到定位界面
- (void)clickToLocate
{
    //把定位界面重新定位的model传过来
    ZMCLocationViewController *locationVC = [[ZMCLocationViewController alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [locationVC returnMarketArray:^(LocationMarketModel *model) {
//        _markets = array;
        _locationModel = model;
        
        [OMGToast showWithText:[NSString stringWithFormat:@"已为您切换到 %@", model.name] bottomOffset:50];
        
        [weakSelf sendRequest];
    }];
    
    locationVC .hidesBottomBarWhenPushed = YES;
    locationVC.markets = _markets;
    locationVC.provincesStr = _provincesStr;
    locationVC.cityStr = _cityStr;
    locationVC.countyStr = _countyStr;
    [self.navigationController pushViewController:locationVC animated:YES];
}


#pragma mark- 点击导航栏右侧按钮搜索
- (void)clickToSearch
{
    ZMCSearchViewController *searchVC = [[ZMCSearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)clickToRemoveView
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(clickToSearch) title:@"搜索"];
    [[self.view viewWithTag:240] removeFromSuperview];
}


#pragma mark- tableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_homeModel.nearbyMerchantList.count == 0) {
        return 1;
    }else{
        
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return _homeModel.goodsHotList.count + 1;
    }else {
        return _homeModel.nearbyMerchantList.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZMCSpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
            
            for (int i =0; i <3; i ++) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToGoodsDetail:)];
                
                if (i==0) {
                    if (_homeModel.goodsSpecialsList.count > i) {
                        SpecialGoodsModel *model = [SpecialGoodsModel mj_objectWithKeyValues:_homeModel.goodsSpecialsList[i]];
                        ZMCLog(@"%@",model.name);
                        cell.imageView1.tag = [model.goods_id intValue];
                            
                        [cell.imageView1 addGestureRecognizer:tap];
                        cell.imageView1.userInteractionEnabled = YES;
                        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"tejia1"]];
                        
                    }else {
                        cell.imageView1.image = [UIImage imageNamed:@"tejia1"];
                        cell.imageView1.userInteractionEnabled = NO;
                    }
                }
                if (i==1) {
                    if (_homeModel.goodsSpecialsList.count > i) {
                        SpecialGoodsModel *model = [SpecialGoodsModel mj_objectWithKeyValues:_homeModel.goodsSpecialsList[i]];
                        ZMCLog(@"%@",model.name);
                        cell.imageView2.tag = [model.goods_id intValue];
 
                        [cell.imageView2 addGestureRecognizer:tap];
                        cell.imageView2.userInteractionEnabled = YES;
                        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"tejia2"]];
                    }else {
                        cell.imageView2.image = [UIImage imageNamed:@"tejia2"];
                        cell.imageView2.userInteractionEnabled = NO;
                    }
                }
                if (i==2) {
                    if (_homeModel.goodsSpecialsList.count > i) {
                        SpecialGoodsModel *model = [SpecialGoodsModel mj_objectWithKeyValues:_homeModel.goodsSpecialsList[i]];
                        ZMCLog(@"%@",model.name);
                        cell.imageView3.tag = [model.goods_id intValue];
 
                        [cell.imageView3 addGestureRecognizer:tap];

                        cell.imageView3.userInteractionEnabled = YES;
                        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"tejia2"]];
                    }else {
                        cell.imageView3.image = [UIImage imageNamed:@"tejia2"];
                        cell.imageView3.userInteractionEnabled = NO;
                    }
                }
                //            UIImageView *imageView = (UIImageView *)[cell viewWithTag:(50 +i)];
                //            [imageView addGestureRecognizer:tap];
                //            imageView.userInteractionEnabled = YES;
                //            imageView.image = i == 0?[UIImage imageNamed:@"tejia1"]: [UIImage imageNamed:@"tejia2"];
                //
                //            if (_homeModel.goodsSpecialsList.count > i) {
                //                SpecialGoodsModel *model = [SpecialGoodsModel mj_objectWithKeyValues:_homeModel.goodsSpecialsList[i]];
                //                ZMCLog(@"%@",model.pic);
                //                imageView.tag = [model.goods_id intValue];
                //
                //                [imageView sd_setImageWithURL:GET_IMAGEURL_URL(model.pic)];
                //
                //
                ////                [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:i == 0?[UIImage imageNamed:@"tejia1"]: [UIImage imageNamed:@"tejia2"]];
                //            }
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            
            ZMCAdsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellReuseId forIndexPath:indexPath];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToGoodsDetail:)];
            [cell.contentImageView addGestureRecognizer:tap];
            cell.contentImageView.userInteractionEnabled = YES;
            HotGoodsModel *model = [HotGoodsModel mj_objectWithKeyValues:_homeModel.goodsHotList[indexPath.row - 1]];
            [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"guanggaowei"]];
            cell.contentImageView.tag = [model.goods_id intValue];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }else {
        HomeMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:marketCellReuseId forIndexPath:indexPath];
        
        NearbyMerchantModel *model = [NearbyMerchantModel mj_objectWithKeyValues:_homeModel.nearbyMerchantList[indexPath.row]];

        [cell.shopsImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"shouyeShop"]];
        cell.shopsMarket_lab.text = model.market_name;
        
        NSString *str_name = [model.name substringToIndex:1];
        cell.shopsHeadName_lab.text = str_name;
        cell.shopsName_lab.text = model.name;
//        cell.shopsBooth_lab.text = [NSString stringWithFormat:@"-%@",model.booth_no];
        cell.shopsBooth_lab.hidden = YES;
        
        if (model.score <= 2) {
            cell.shopsStarImg.image = [UIImage imageNamed:@"small-one"];
        }else if (model.score <= 4){
            cell.shopsStarImg.image = [UIImage imageNamed:@"small-two"];
        }else if (model.score <= 6){
            cell.shopsStarImg.image = [UIImage imageNamed:@"small-three"];
        }else if (model.score <= 8){
            cell.shopsStarImg.image = [UIImage imageNamed:@"small-four"];
        }else{
            cell.shopsStarImg.image = [UIImage imageNamed:@"small-five"];
        }
        
        cell.shopsNum_lab.text = [NSString stringWithFormat:@"在售商品%ld件",(long)model.selling_goods_cnt];
        cell.shopsOrderNum_lab.text = [NSString stringWithFormat:@"已售%ld单",(long)model.sold_orders_cnt];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            return 176;
        }
        return 140;
    }else {
        return 100;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else {
        NearbyMerchantModel *model = [NearbyMerchantModel mj_objectWithKeyValues:_homeModel.nearbyMerchantList[indexPath.row]];
        ShopsDetailVC *shopVc = [[ShopsDetailVC alloc] init];
        shopVc.merchant_id = [NSString stringWithFormat:@"%ld", (long)model.ID];
        [self.navigationController pushViewController:shopVc animated:YES];
        ZMCLog(@"跳转店铺！");
    }
    
}
#pragma mark- 自定义区头-图片,标签和按钮
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Volume"];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(16, 14));
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"今日特价";
        label.textColor = StringDarkColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_top);
            make.left.mas_equalTo(37);
            make.size.mas_equalTo(CGSizeMake(70, 14));
            
        }];
        
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:StringMiddleColor forState:UIControlStateNormal];
        [button setTitle:@"更多 >>" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickToMoreGoods) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(45, 12));
        }];
        
        return view;
    }else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        UIImageView *imageView = [[UIImageView alloc] init];
        if (section == 0) {
            imageView.image = [UIImage imageNamed:@"Volume"];
        }else {
            imageView.image = [UIImage imageNamed:@"marketImg"];
        }
        
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(12, 18));
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"附近的菜场商户";
        label.textColor = StringDarkColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_top);
            make.left.mas_equalTo(37);
            make.size.mas_equalTo(CGSizeMake(120, 14));
            
        }];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.text = @"满39元免3元运费";
        rightLabel.textColor = ThemeGreenColor;
        rightLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_top);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(120, 14));
            
        }];
        
        return view;
    }
    
    
}


#pragma mark- 点击加载更多今日特价商品
- (void)clickToMoreGoods
{
    ZMCSpecialViewController *specialVC = [[ZMCSpecialViewController alloc] init];
    specialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:specialVC animated:YES];
}

#pragma mark- 自定义表头-广告轮播条和下面的按钮
- (UIView *)getHeaderView
{
    CGFloat hight = kScreenWidth * 8 / 15;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, hight + 110)];
    
    SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, hight) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    banner.backgroundColor = _mainTableView.backgroundColor;
    banner.autoScrollTimeInterval = 4;
    
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
//    [imagesURLStrings addObject:@"http://image.zenmechi.cc/img/9/b3/56/9b35657402e3587643.jpg"];
    
//    CarouselsModel *model = _homeModel.carousels
    
    ZMCLog(@"---->>>>>>>%ld", _bannerModelArray.count);
    for (int i = 0; i < _homeModel.carousels.count; i ++) {
        CarouselsModel *model = [CarouselsModel mj_objectWithKeyValues:_homeModel.carousels[i]];
//        ZMCLog(@"%@",model.pic);
//        NSString *str = model.pic;
        [imagesURLStrings addObject:model.pic];
    }
    banner.imageURLStringsGroup = imagesURLStrings;
    banner.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [view addSubview:banner];
    
    for (int i =0; i <4; i ++) {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:_buttonImageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickToNextView:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.tag = i;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(23 + i* (kScreenWidth -46 -50)/3.0);
            make.top.equalTo(banner.mas_bottom).offset(15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = _buttonTitleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = StringDarkColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.centerY.equalTo(button.mas_centerY).offset(40);
            make.width.equalTo(button.mas_width).offset(25);
            make.height.mas_equalTo(14);
        }];
    }
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

#pragma mark- 点击表头中的banner条中的图片,跳转相应的界面
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    CarouselsModel *model = [CarouselsModel mj_objectWithKeyValues:_homeModel.carousels[index]];
    NSString *url = model.url;
//    url = @"howeat://1/{1111}";
    if ([url rangeOfString:@"howeat://1"].location != NSNotFound) {
        
        if ([url isEqualToString:@"howeat://1"]) {
            //跳转菜谱
            self.tabBarController.selectedIndex = 1;
        }else {
            //跳转菜谱详情
            NSString *str = [url substringFromIndex:11];
//            NSString *strId = [str substringToIndex:[str length] - 1];
//            ZMCLog(@"%@",strId);
            
            ZMCCookBookDetailViewController *detailVC = [[ZMCCookBookDetailViewController alloc] init];
            detailVC.cookBookID = [str longLongValue];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        
    }else if ([url rangeOfString:@"howeat://2"].location != NSNotFound) {
        
        if ([url isEqualToString:@"howeat://2"]) {
            //跳转逛菜场
            self.tabBarController.selectedIndex = 2;
        }else {
//            //跳转商品详情
//            NSString *str = [url substringFromIndex:12];
//            NSString *strId = [str substringToIndex:[str length] - 1];
//            ZMCLog(@"%@",strId);
//            
//            GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
//            vc.goods_id = strId;
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if ([url isEqualToString:@"howeat://3"]) {
        
        Check_Login
        
        //跳转充值
        ZMCPayViewController *vc = [[ZMCPayViewController alloc] initWithNibName:@"ZMCPayViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([url rangeOfString:@"howeat://4"].location != NSNotFound) {
        //跳转特价
//        [self clickToMoreGoods];
        
        if ([url isEqualToString:@"howeat://4"]) {
            //跳转逛菜场
//            self.tabBarController.selectedIndex = 2;
        }else {
            //跳转商品详情
            NSString *str = [url substringFromIndex:11];
//            NSString *strId = [str substringToIndex:[str length]];
//            ZMCLog(@"%@",strId);
            
            GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
            vc.goods_id = str;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if ([url isEqualToString:@"howeat://5"]) {
        //跳转注册
        ZMCRegisterViewController *registerVc = [[ZMCRegisterViewController alloc] init];
        [self presentViewController:registerVc animated:YES completion:nil];
    }else if ([url rangeOfString:@"howeat://6"].location != NSNotFound){
        if ([url isEqualToString:@"howeat://6"]) {
            
        }else{
            NSString *shopStr = [url substringFromIndex:11];
            
            ShopsDetailVC *shopVc = [[ShopsDetailVC alloc] init];
            shopVc.merchant_id = shopStr;
            [self.navigationController pushViewController:shopVc animated:YES];
            
        }
    }
}

#pragma mark- 点击表头中的按钮,跳转页面
- (void)clickToNextView:(UIButton *)button
{
    if (button.tag == 0) {
//        活动界面
        ZMCActivityViewController *activityVC = [[ZMCActivityViewController alloc] init];
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:YES];
    }
    if (button.tag == 1) {
//        大厨到家界面
        ZMCCookToHomeViewController *cookVC = [[ZMCCookToHomeViewController alloc] init];
//        self.tabBarController.tabBar.hidden = YES;
        cookVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cookVC animated:YES];
    }
    if (button.tag == 2) {
        
        Check_Login
//        查看订单
        ZMCMyorderViewController *allVC = [[ZMCMyorderViewController alloc] init];
        allVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:allVC animated:YES];
    }
    if (button.tag == 3) {
        Check_Login
        if (!TOKEN) {
            [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
        }else{
        
            //        查看我的积分
            ZMCMyintegralViewController *integerVC = [[ZMCMyintegralViewController alloc] init];
            integerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:integerVC animated:YES];
        }
    }
}

//点击加载商品详情
- (void)clickToGoodsDetail:(UITapGestureRecognizer *)tap
{
//    ZMCGoodsDetailsViewController *goodsVC = [[ZMCGoodsDetailsViewController alloc] init];
//    goodsVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:goodsVC animated:YES];
    /**
     *  123
     */
//    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"MarketStoryboard" bundle:nil];
//    ZMCGoodsDetailsViewController *goodsDetailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
//    goodsDetailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:goodsDetailVC animated:YES];
    

    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
    vc.goods_id = ChangeNSIntegerToStr(tap.view.tag);
    [self.navigationController pushViewController:vc animated:YES];

}



#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if ([USER_DEFAULT objectForKey:@"infoArray"] != nil) {
        
    }
    
    CLLocation *location=[locations lastObject];//取出最后一个位置
//    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
//    [self sendRequestWithCoordinate:coordinate];
    [self sendRequestWithlatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude] longitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
    
    //如果不需要实时定位，使用完及时关闭定位服务
//    [_locationManager stopUpdatingLocation];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        ZMCLog(@"%@",error);
        
        for (CLPlacemark *place in placemarks) {
            
            //                           label.text = place.name;
            ZMCLog(@"name============%@",place.name);//位置名
            ZMCLog(@"街道======%@",place.thoroughfare);// 街道
            ZMCLog(@"子街道======%@",place.subThoroughfare);//子街道
            ZMCLog(@"市======%@",place.locality);//市
            ZMCLog(@"区======%@",place.subLocality);//区
            ZMCLog(@"国家======%@",place.country);//国家
            ZMCLog(@"%@---%@--%@--%@--%@--",place.administrativeArea, place.locality, place.subLocality, place.thoroughfare, place.subThoroughfare);
            ZMCLog(@"%@--%@--%@--%@--%@", place.subAdministrativeArea, place.postalCode, place.ISOcountryCode, place.inlandWater, place.ocean);
            
            _provincesStr = place.administrativeArea;
            _cityStr = place.locality;
            _countyStr = place.subLocality;
            _street = place.thoroughfare;
        }
        
        
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            ZMCLog(@"查不到位置信息，错误原因%@",error);
        } else {
            CLPlacemark *placemark = placemarks[0];
            
            NSArray *locationInfoArray = @[placemark.administrativeArea,placemark.locality,placemark.subLocality];
            [USER_DEFAULT setObject:locationInfoArray forKey:@"infoArray"];
            [USER_DEFAULT synchronize];
        }
    }];
    
//    CLLocation *newLocation = locations[0];
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation:newLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error){
//                       
//                       ZMCLog(@"%@",error);
//                       
//                       for (CLPlacemark *place in placemarks) {
//                           
//                           //                           label.text = place.name;
//                           ZMCLog(@"name============%@",place.name);//位置名
//                           ZMCLog(@"街道======%@",place.thoroughfare);// 街道
//                           ZMCLog(@"子街道======%@",place.subThoroughfare);//子街道
//                           ZMCLog(@"市======%@",place.locality);//市
//                           ZMCLog(@"区======%@",place.subLocality);//区
//                           ZMCLog(@"国家======%@",place.country);//国家
//                           ZMCLog(@"%@--%@--%@--%@--",place.locality, place.subLocality, place.thoroughfare, place.subThoroughfare);
//                           ZMCLog(@"%@--%@--%@--%@--%@--%@",place.administrativeArea, place.subAdministrativeArea, place.postalCode, place.ISOcountryCode, place.inlandWater, place.ocean);
//                           
//                           _provincesStr = place.administrativeArea;
//                           _cityStr = place.locality;
//                           _countyStr = place.subLocality;
//                       }
//                   }];
}



- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    static int a = 0;//定位失败后，不在重复提醒失败信息
    if (a != 0) {
        return;
    }
//    ALERT_MSG(@"提示", @"糟糕，定位失败，请稍候重试！");c    [_locationManager stopUpdatingLocation];
    a ++;
    
}


- (void)sendRequestWithlatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    __weak typeof(self) weakSelf = self;


    [HomeNetwork requestNearbyMarketWithCoordinateLatitude:[latitude floatValue] andLongitude:[longitude floatValue] andCompleteBlock:^(NSArray * array) {

        _markets = array;
        
        
        
        [weakSelf sendRequest];
    }];

}

@end
