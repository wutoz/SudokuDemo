//
//  WTSudokuView.m
//  DirectBank
//
//  Created by Yorke on 14/10/31.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "WTSudokuView.h"

#define kGesturePasswordBackground @"GesturePasswordBackground.png"

#define kSpace 20.0f

@interface WTSudokuView ()

@property(nonatomic,strong)UILabel *titleLab;

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UIImageView *imageView;

@property(nonatomic,strong)NSMutableArray *secretArr;

@end

@implementation WTSudokuView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (void)setup{
    _secretArr = [NSMutableArray array];
    CGSize size = self.frame.size;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLab];
    self.titleLab.hidden = YES;
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(size.width / 2 - 160, size.height / 2 - 150, 320, 320)];
    CGSize centerSize = centerView.frame.size;
    [self addSubview:centerView];
    NSMutableArray *btnArray = [NSMutableArray array];
    for(int i = 0; i < 9; i++){
        WTSudokuButton *btn = [[WTSudokuButton alloc]initWithFrame:CGRectMake(i % 3 * (centerSize.width / 3) + kSpace,floorl(i / 3) * (centerSize.width / 3) + kSpace, (centerSize.width - kSpace * 6) / 3, (centerSize.width - kSpace * 6) / 3)];
        btn.tag = i;
        [centerView addSubview:btn];
        [btnArray addObject:btn];
    }
    
    _touchView = [[WTTouchView alloc]initWithFrame:centerView.frame];
    _touchView.btnArray = btnArray;
    [self addSubview:_touchView];
}

- (void)showTitle:(NSString *)title{
    self.titleLab.hidden = NO;
    _titleLab.text = title;
}

- (void)showAvatar:(UIImage *)image{
    
}

- (UILabel *)titleLab{
    if(!_titleLab){
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, self.frame.size.width, 30)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kGesturePasswordBackground]];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _imageView;
}

- (UIImageView *)avatarView{
    if(!_avatarView){
        
    }
    return _avatarView;
}



@end

@implementation WTSudokuButton

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        _type = WTSudokuButtonTypeNormal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect frame = rect;
    switch (self.type) {
        case WTSudokuButtonTypeNormal:
        {
            CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
            CGContextSetLineWidth(ctx,2);
            frame = CGRectMake(2, 2, rect.size.width-3, rect.size.height-3);
            CGContextAddEllipseInRect(ctx,frame);
            CGContextStrokePath(ctx);
            
            CGContextSetRGBFillColor(ctx,30/255.f, 175/255.f, 235/255.f,0.3);
            CGContextAddEllipseInRect(ctx,frame);
        }
            break;
        case WTSudokuButtonTypeSelected:
        {
            CGContextSetRGBStrokeColor(ctx, 2/255.f, 174/255.f, 240/255.f,1);
            CGContextSetLineWidth(ctx,2);
            frame = CGRectMake(2, 2, rect.size.width-3, rect.size.height-3);
            CGContextAddEllipseInRect(ctx,frame);
            CGContextStrokePath(ctx);
            
            CGContextSetRGBFillColor(ctx,2/255.f, 174/255.f, 240/255.f,1);
            frame = CGRectMake(rect.size.width / 2 - rect.size.width / 8 + 1, rect.size.height / 2 - rect.size.height / 8, rect.size.width / 4, rect.size.height / 4);
            CGContextAddEllipseInRect(ctx, frame);
            CGContextFillPath(ctx);
            
            CGContextSetRGBFillColor(ctx,30/255.f, 175/255.f, 235/255.f,0.3);
            CGContextAddEllipseInRect(ctx,frame);
            CGContextFillPath(ctx);
            
        }
            break;
        case WTSudokuButtonTypeError:
        {
            CGContextSetRGBStrokeColor(ctx, 208/255.f, 36/255.f, 36/255.f,1);
            CGContextSetLineWidth(ctx,2);
            frame = CGRectMake(2, 2, rect.size.width-3, rect.size.height-3);
            CGContextAddEllipseInRect(ctx,frame);
            CGContextStrokePath(ctx);
            
            CGContextSetRGBFillColor(ctx,208/255.f, 36/255.f, 36/255.f,1);
            frame = CGRectMake(rect.size.width / 2 - rect.size.width / 8 + 1, rect.size.height / 2 - rect.size.height / 8, rect.size.width / 4, rect.size.height / 4);
            CGContextAddEllipseInRect(ctx, frame);
            CGContextFillPath(ctx);
            
            CGContextSetRGBFillColor(ctx,208/255.f, 36/255.f, 36/255.f,0.3);
            CGContextAddEllipseInRect(ctx,frame);
            CGContextFillPath(ctx);
        }
            break;
    }
}

@end

@interface WTTouchView (){
    CGPoint lineEndPoint;
}

@property (nonatomic, strong) NSMutableArray *touchesArray;

@end

@implementation WTTouchView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _touchesArray = [NSMutableArray array];
        _type = WTTouchViewTypeSetting;
        _success = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_touchesArray removeAllObjects];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for(WTSudokuButton *btn in self.btnArray){
        if(CGRectContainsPoint(btn.frame, point)){
            btn.type = WTSudokuButtonTypeSelected;
            [_touchesArray addObject:btn];
            [btn setNeedsDisplay];
        }
    }
    lineEndPoint = point;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for(WTSudokuButton *btn in self.btnArray){
        if(CGRectContainsPoint(btn.frame, point) && ![_touchesArray containsObject:btn]){
            btn.type = WTSudokuButtonTypeSelected;
            [_touchesArray addObject:btn];
            [btn setNeedsDisplay];
        }
    }
    lineEndPoint = point;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableString *result = [NSMutableString string];
    for(WTSudokuButton *btn in _touchesArray){
        [result appendFormat:@"%ld",btn.tag];
    }
    
    switch (_type) {
        case WTTouchViewTypeSetting:
        {
            if(_settingDelegate && [_settingDelegate respondsToSelector:@selector(settingPassword:)]){
                _success = [_settingDelegate settingPassword:result];
            }
        }
            break;
        case WTTouchViewTypeVerify:
        {
            if(_verifyDelegate && [_verifyDelegate respondsToSelector:@selector(verifyPassword:)]){
                _success = [_verifyDelegate verifyPassword:result];
            }
        }
            break;
    }

    if(_success){
        
    }else{
        for(WTSudokuButton *btn in _touchesArray){
            [btn setType:WTSudokuButtonTypeError];
            [btn setNeedsDisplay];
        }
        [self setNeedsDisplay];
    }
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        self.userInteractionEnabled = YES;
    });
}

- (void)drawRect:(CGRect)rect{
    for(int i = 0; i < _touchesArray.count; i++){
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        if(_success){
            CGContextSetRGBStrokeColor(ctx, 2/255.f, 174/255.f, 240/255.f, 0.7);//线条颜色
        }else{
            CGContextSetRGBStrokeColor(ctx, 208/255.f, 36/255.f, 36/255.f, 0.7);
        }
        
        CGContextSetLineWidth(ctx, 5);
        WTSudokuButton *btn = _touchesArray[i];
        CGPoint point = CGPointMake(btn.frame.origin.x + btn.frame.size.width / 2, btn.frame.origin.y + btn.frame.size.height / 2);
        CGContextMoveToPoint(ctx, point.x, point.y);
        
        if(_touchesArray.count - 1 > i){
            btn = _touchesArray[i + 1];
            point = CGPointMake(btn.frame.origin.x + btn.frame.size.width / 2, btn.frame.origin.y + btn.frame.size.height / 2);
            CGContextAddLineToPoint(ctx, point.x, point.y);
        }else{
            if(_success){
                CGContextAddLineToPoint(ctx, lineEndPoint.x, lineEndPoint.y);
            }
        }
        CGContextStrokePath(ctx);
    }
}

- (void)clear {
    [_touchesArray removeAllObjects];
    _success = YES;
    for(WTSudokuButton *btn in self.btnArray){
        btn.type = WTSudokuButtonTypeNormal;
        [btn setNeedsDisplay];
    }
    
    [self setNeedsDisplay];
}

@end