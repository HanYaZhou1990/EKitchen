//
//  Define.h
//  OChat
//
//  Created by julong on 14/12/24.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

//颜色和透明度设置
#define RGBA(r,g,b,a)    [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
//16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) //屏幕高度

#define NAV_HEIGHT  ((IOS7)?64:44) //nav的高度
#define TAB_HEIGHT 49 //tab的高度
//判断是否为4寸屏
#define is4Inch                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] && [[UIScreen mainScreen] currentMode].size.height == 1136)

//软件版本号
#define SOFTWARE_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"])

//判断系统版本是ios7以上
#define IOS7   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

//判断系统版本是ios8以上
#define IOS8   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

//打印函数
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"[FileName:%s]\n" "[FunctionName:%s]\n" "[LineNumber:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__); //打印函数
#define DLOGDATA(data)             LSLOG(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])  //数据打印函数
#else
#define DLog(...);
#define DLOGDATA(...);
#endif


#define userAccountEKitchen     @"userCountEKitchen" //用户账号唯一标识符id
#define userTypeEKitchen        @"userTypeEKitchen" //身份标示 0顾客 1厨师

#define refreshMeVCNotification @"refreshMeVCNotification" //刷新设置界面

/*****************服务器地址相关**************/

#define BASE_PLAN_URL      @"http://121.199.49.131/open/api"

/*****************接口相关**************/

//统一参数
#define appKeyEkitchen          @"00001"
#define versionEkitchen         @"1.0"    //服务方法的版本号
#define formatEkitchen          @"json"   //报文的格式，支持XML和JSON，默认JSON
#define localeEkitchen          @"zh_CN"  //本地化类型，默认zh_CN
#define clientEkitchen          @"iPhone" //客户端类型(iPad,iPhone,Android,WP,Mac,Windows,Linux)
#define timeStampEkitchen       ([NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]*1000])

//客户端唯一标示号
#define identifyEkitchen        ([[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""])


//会员类型
#define member_type_list       @"member.type.list"

//会员登陆
#define member_login           @"member.login"

//会员注册
#define member_register        @"member.register"

//获取会员个人资料
#define member_detail          @"member.detail"

//修改并完善会员个人资料
#define member_modify          @"member.modify"

//修改会员个人密码
#define member_change_passwd   @"member.change.passwd"

//上传会员头像
#define member_photo_upload    @"member.photo.upload"

//会员注销登录
#define member_logout          @"member.logout"


//获取厨师等级列表
#define cooker_rank_list       @"cooker.rank.list"

//厨师登陆
#define cooker_login           @"cooker.login"

//厨师注册
#define cooker_register        @"cooker.register"

//获取厨师个人资料
#define cooker_detail          @"cooker.detail"

//修改并完善厨师个人资料
#define cooker_modify          @"cooker.modify"

//修改厨师个人密码
#define cooker_change_passwd   @"cooker.change.passwd"

//上传厨师头像
#define cooker_photo_upload    @"cooker.photo.upload"

//厨师注销登录
#define cooker_logout          @"cooker.logout"

//获取厨师之星列表
#define cooker_star            @"cooker.star"


//获取最新版本信息
#define check_version          @"check.version"


//获取会员登记的地址列表
#define receiver_get_list      @"receiver.get.list"

//会员登记新地址
#define receiver_register      @"receiver.register"

//变更会员登记地址
#define receiver_modify        @"receiver.modify"

//删除会员登记地址
#define receiver_delete        @"receiver.delete"

//获取会员登记地址的详细信息
#define receiver_detail        @"receiver.detail"


//获取地区列表信息
#define area_get_list          @"area.get.list"










