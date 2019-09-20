//
//  RSSParser.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "RSSParser.h"

#import "Article.h"
#import "Utils.h"

#pragma mark - Constants

static NSString *kLinkParameter = @"?displayMobileNavigation=0";

#pragma mark - RSSParser Interface

@interface RSSParser()

@property (nonatomic) NSMutableArray<Article *> *articles;
@property (nonatomic, strong) Article *currArticle;
@property (nonatomic, strong) NSMutableString *currElement;

@end

@implementation RSSParser

#pragma mark - Public Methods

- (RSSParser *)initWithDelegate:(id<RSSParserDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.articles = [[NSMutableArray alloc] init];
        self.delegate = delegate;
    }
    
    return self;
}

- (void)parse:(NSString *)urlStr {
    [self.articles removeAllObjects];
    
    // Enter background thread
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [xmlparser setDelegate:self];
        [xmlparser setShouldResolveExternalEntities:YES];
        [xmlparser setShouldProcessNamespaces:NO];
        [xmlparser setShouldReportNamespacePrefixes:NO];
        [xmlparser parse];
    });
}

#pragma mark - RSSParserDelegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    NSLog(@"didStartElement --> %@", elementName);
    
    if ([elementName isEqualToString:@"item"]) {
        self.currArticle = [[Article alloc] init];
    }
    
    if ([elementName isEqualToString:@"media:content"]) {
        Media *media = [[Media alloc] init];
        
        media.urlStr = [attributeDict objectForKey:@"url"];
        media.type = [attributeDict objectForKey:@"type"];
        media.medium = [attributeDict objectForKey:@"medium"];
        media.width = [attributeDict objectForKey:@"width"];
        media.height = [attributeDict objectForKey:@"height"];
        
        self.currArticle.media = media;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"foundCharacters --> %@", string);
    
    if(!self.currElement) {
        self.currElement = [[NSMutableString alloc] initWithString:string];
    } else {
        [self.currElement appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"didEndElement   --> %@", elementName);
    
    if ([elementName isEqualToString:@"item"]) {
        [self.articles addObject:self.currArticle];
    } else if ([elementName isEqualToString:@"title"]) {
        self.currArticle.title = [self.currElement trimWhiteSpace];
    } else if ([elementName isEqualToString:@"pubDate"]) {
        self.currArticle.pubDate = [self.currElement trimWhiteSpace];;
    } else if ([elementName isEqualToString:@"description"]) {
        self.currArticle.descript = [self.currElement trimWhiteSpace];
    } else if ([elementName isEqualToString:@"link"]) {
        [self.currElement appendString:kLinkParameter];
        self.currArticle.link = [self.currElement trimWhiteSpace];
    }
    
    self.currElement = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
    // Enter main thread to update UI
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if ([self.delegate respondsToSelector:@selector(didCompleteParse:)]) {
            [self.delegate didCompleteParse:self.articles];
        }
    });
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"parseErrorOccurred   --> %@", parseError);
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"validationErrorOccurred   --> %@", validationError);
}

@end
