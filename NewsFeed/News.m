//
//  News.m
//  NewsFeed
//
//  Created by Gnatyuk Ivan on 21.06.16.
//  Copyright © 2016 Gnatyuk Ivan. All rights reserved.
//

#import "News.h"
#import "NSDate+Helper.h"

static NSDateFormatter *_dateFormatterNews;

@implementation News


- (instancetype)initWithDictionary:(NSDictionary *)dictNews {
    self = [super init];
    if (!self) return nil;
    
    if (!_dateFormatterNews) {
        _dateFormatterNews = [self datefornatterNews];
    }
    
    self.newsTitle = dictNews[@"text"][@"plain"];
    self.newsDescription = dictNews[@"description"];
    self.newsUrl = [NSURL URLWithString:dictNews[@"link"]];
    self.newsDate = [_dateFormatterNews dateFromString:dictNews[@"date"]];
    NSDateFormatter *dateAux = [[NSDateFormatter alloc] init];
    [dateAux setDateFormat:@"EEEE dd MMMM YYYY"];
    self.newsDateText = [dateAux stringFromDate:self.newsDate];
    self.newsAttachmentUrl = [NSURL URLWithString:dictNews[@"attachment"][@"picture-link"]];
    NSDictionary *dictImageInfo = dictNews[@"enclosure"];
    self.newsImageUrl = [NSURL URLWithString:dictNews[@"author"][@"picture-link"]];
  
    return self;
}

+ (NSString *)sourceTitle:(NSString *)title {
    NSRange range = [title rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return [title substringToIndex:range.location];
    } else {
        return title;
    }
}

- (NSString *)description {
      return [NSString stringWithFormat:@"%@", @{@"title" :  self.newsTitle}];
}

- (NSDateFormatter *)datefornatterNews {
    _dateFormatterNews = [[NSDateFormatter alloc] init];
    _dateFormatterNews.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    [_dateFormatterNews setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    
    return _dateFormatterNews;
}

@end
