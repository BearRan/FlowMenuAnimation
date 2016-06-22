//
//  UITextField+BearLimitLength.m
//  Pods
//
//  Created by apple on 16/6/8.
//
//

#import "UITextField+BearLimitLength.h"
#import "objc/runtime.h"

static const void *limitLengthKey = &limitLengthKey;

@implementation UITextField (BearLimitLength)

- (NSNumber *)limitLength
{
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength
{
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addLimitLengthObserver:[limitLength intValue]];
}

//  增加限制位数的通知
- (void)addLimitLengthObserver:(int)length
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextFieldTextDidChangeNotification object:self];
}

//  限制输入的位数
- (void)limitLengthEvent
{
    if ([self.text length] > [self.limitLength intValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}

@end
