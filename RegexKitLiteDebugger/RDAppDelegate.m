//
//  RDAppDelegate.m
//  RegexKitLiteDebugger
//
//  Created by Wutian on 13-5-31.
//  Copyright (c) 2013年 wutian. All rights reserved.
//

#import "RDAppDelegate.h"
#import "RegexKitLite.h"

@implementation RDAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.regexTextField.cell setFocusRingType:NSFocusRingTypeNone];
    
    self.contentTextView.font = [NSFont fontWithName:@"Menlo" size:13];
    self.contentTextView.textContainerInset = NSMakeSize(0, 3);
    
    self.resultTextView.textContainerInset = NSMakeSize(0, 3);
}

- (void)updateResult
{
    // 获取填写的正则和内容
    NSString * regex = self.regexTextField.stringValue;
    NSString * content = self.contentTextView.string;
    
    // 首先对regex进行逆转义，模拟硬编码时声明NSString的情况
    NSMutableString * unescapedRegex = [NSMutableString stringWithString:regex];

#define Replace(string,with) [unescapedRegex replaceOccurrencesOfString:string withString:with options:0 range:NSMakeRange(0, unescapedRegex.length)]

    Replace(@"\\\'", @"\'");
    Replace(@"\\\"", @"\"");
    Replace(@"\\\?", @"\?");
    Replace(@"\\\\", @"\\");
    // \n, \t, \b 在此不考虑
    
    
    // 使用逆转义过的正则进行解析并更新resultTextView
    NSRange contentRange = NSMakeRange(0, content.length);
    [self.resultTextView setString:content];
    [self.resultTextView.textStorage removeAttribute:NSFontAttributeName range:contentRange];
    [self.resultTextView.textStorage removeAttribute:NSBackgroundColorAttributeName range:contentRange];
    
    [self.resultTextView.textStorage addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Menlo" size:13] range:contentRange];
    
    [content enumerateStringsMatchedByRegex:unescapedRegex options:0 inRange:NSMakeRange(0, content.length) error:NULL enumerationOptions:0 usingBlock:^(NSInteger captureCount, NSString *const *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        NSRange range = capturedRanges[0];
        
        [self.resultTextView.textStorage addAttribute:NSBackgroundColorAttributeName value:[NSColor redColor] range:range];
    }];
}

#pragma mark - Delegate Methods

- (void)controlTextDidChange:(NSNotification *)obj
{
    if (obj.object == self.regexTextField)
    {
        [self updateResult];
    }
}

- (void)textDidChange:(NSNotification *)notification
{
    if (notification.object == self.contentTextView)
    {
        [self updateResult];
    }
}

@end
