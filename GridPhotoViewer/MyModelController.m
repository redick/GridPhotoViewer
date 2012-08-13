//
//  MyModelController.m
//  GridPhotoViewer
//
//  Created by Shen Steven on 8/13/12.
//  Copyright (c) 2012 syshen. All rights reserved.
//

#import "MyModelController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MyModelController ()

@property (strong, nonatomic) NSArray *assets;

@end

@implementation MyModelController


- (id)initWithCompletionBlock:(void (^)(void))callback
{
    self = [super init];
    if (self) {
        [self loadSavedPhotoAssetsGroup:^(ALAssetsGroup *group) {
            NSMutableArray *newArray = [NSMutableArray array];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [newArray addObject:result];
                }
            }];
            
            self.assets = [newArray copy];
            
            callback();
        }];
    }
    return self;
}

- (NSUInteger) numberOfPhotos
{
    return [self.assets count];
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    return [UIImage imageWithCGImage:[[self.assets objectAtIndex:index] thumbnail]];
}

- (void) loadSavedPhotoAssetsGroup:(void(^)(ALAssetsGroup*))callback
{
    ALAssetsLibrary *library = [[self class] defaultLibrary];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            *stop = YES;
            callback (group);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Fail to load photos from Assets Library");
    }];
}

+ (ALAssetsLibrary *) defaultLibrary
{
    static ALAssetsLibrary *library = nil;
    if (!library) {
        library = [[ALAssetsLibrary alloc] init];
    }
    return library;
}

@end
