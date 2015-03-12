//
//  WTSudokuView.h
//  DirectBank
//
//  Created by Yorke on 14/10/31.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - WTSudokuView

@class WTTouchView;
@interface WTSudokuView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) WTTouchView *touchView;

- (void)showTitle:(NSString *)title;

- (void)showAvatar:(UIImage *)image;

@end

#pragma mark - WTSudokuButton

typedef NS_ENUM(NSInteger, WTSudokuButtonType) {
    WTSudokuButtonTypeNormal = 1,
    WTSudokuButtonTypeSelected,
    WTSudokuButtonTypeError
};

@interface WTSudokuButton : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) WTSudokuButtonType type;

@end

#pragma mark - WTTouchView

@protocol WTTouchSettingDelegate <NSObject>

- (BOOL)settingPassword:(NSString *)password;

@end

@protocol WTTouchVerifyDelegate <NSObject>

- (BOOL)verifyPassword:(NSString *)password;

@end

typedef NS_ENUM(NSInteger, WTTouchViewType) {
    WTTouchViewTypeSetting = 1,
    WTTouchViewTypeVerify
};

@interface WTTouchView : UIView

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) WTTouchViewType type;

@property (nonatomic, assign) id<WTTouchSettingDelegate> settingDelegate;

@property (nonatomic, assign) id<WTTouchVerifyDelegate> verifyDelegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
