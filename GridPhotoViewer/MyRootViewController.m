//
//  MyRootViewController.m
//  GridPhotoViewer
//
//  Created by Shen Steven on 8/13/12.
//  Copyright (c) 2012 syshen. All rights reserved.
//

#import "MyRootViewController.h"
#import "MyCollectionViewCell.h"
#import "MyModelController.h"

@interface MyRootViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self modelController];
}

- (MyModelController *)modelController
{
    static MyModelController *mc = nil;
    if (!mc) {
        mc = [[MyModelController alloc] initWithCompletionBlock:^{
            [self.collectionView reloadData];
        }];
    }
    return mc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCustomCell";
    MyCollectionViewCell *cell = (MyCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCollectionViewCell alloc] init];
    }
    
    cell.imageView.image = [[self modelController] imageAtIndex:indexPath.row];
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self modelController] numberOfPhotos];
}

#pragma mark - UICollectionViewDelegate methods

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d selected", indexPath.row);
}

@end
