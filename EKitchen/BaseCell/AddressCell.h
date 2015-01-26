//
//  AddressCell.h
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressCellDelegate <NSObject>

-(void)editBtnClicked:(id)sender;
-(void)deleteBtnClicked:(id)sender;

@end

@interface AddressCell : UITableViewCell
{
    id<AddressCellDelegate> addressDelegate;
}

@property (nonatomic,assign,setter = setDelegate:) id<AddressCellDelegate> addressDelegate;

- (void)setUseNameStr:(NSString *)useNameStr  andAddressStr:(NSString *)addressStr andIsDefult:(BOOL)isDefult andRow:(NSInteger)row;

@end
