//
//  TextViewCell.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "TextViewCell.h"

@interface TextViewCell () <UITextViewDelegate> {
    UITextView          *_leaveMessageTextView;
}

@end

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leaveMessageTextView = [[UITextView alloc] init];
        _leaveMessageTextView.delegate = self;
        _leaveMessageTextView.text = @"留言";
        _leaveMessageTextView.textColor = UIColorFromRGB(0x3D3D3D);
        _leaveMessageTextView.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_leaveMessageTextView];
        }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _leaveMessageTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, CGRectGetHeight(self.frame));
}

#pragma mark -
#pragma mark UITextViewDelegate -
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"留言"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqual:[NSNull null]] || [textView.text isEqualToString:@""] || textView.text == nil) {
        textView.text = @"留言";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
