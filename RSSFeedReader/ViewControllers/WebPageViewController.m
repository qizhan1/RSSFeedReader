//
//  WebPageViewController.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "WebPageViewController.h"
#import <WebKit/WebKit.h>

#pragma mark - WebPageViewController Interface

@interface WebPageViewController () <WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebPageViewController

#pragma mark - View Life Cycle

- (void)loadView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSURL alloc] initWithString:self.link];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

@end
