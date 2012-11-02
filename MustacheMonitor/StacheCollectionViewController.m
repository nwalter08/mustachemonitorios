//
//  StacheCollectionViewController.m
//  MustacheMonitor
//
//  Created by Nick Walter on 11/2/12.
//  Copyright (c) 2012 Nick Walter. All rights reserved.
//

#import "StacheCollectionViewController.h"
#import "StachePickCell.h"

@interface StacheCollectionViewController ()

@end

@implementation StacheCollectionViewController

@synthesize CollView = _CollView;


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
	// Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setItemSize:CGSizeMake(80, 50)];
    
    [flowLayout setMinimumLineSpacing:5.0f];
    
    [flowLayout setMinimumInteritemSpacing:1.0f];
    
    
    
    
    
    self.CollView.delegate = self;
    
    self.CollView.dataSource = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    StachePickCell *cell = (StachePickCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StachePickCell" forIndexPath:indexPath];
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StachePickCell *cell = (StachePickCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StachePickCell" forIndexPath:indexPath];
    
    cell = (StachePickCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    UIImage *checkImg = [UIImage imageNamed:@"green-select-stash.png"];
    //If green check image
    if (cell.GreenCheckBtn.image == checkImg)
    {
        //Turn to red
        [cell.GreenCheckBtn setImage:[UIImage imageNamed:@"red-no-stash.png"]];
    }
    else{
        //Turn to green
        [cell.GreenCheckBtn setImage:checkImg];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
