//
//  TableViewController.m
//  SudokuDemo
//
//  Created by Yorke on 15/3/11.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import "TableViewController.h"
#import "SudokuViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) BOOL gestureOpen;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = @[@"设置手势密码",@"验证手势密码"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _gestureOpen = [[NSUserDefaults standardUserDefaults]boolForKey:kGesture];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(_gestureOpen){
        return _data.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    
    if(indexPath.row == 0){
        cell.textLabel.text = @"手势密码";
        UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 5, 50, 30)];
        [sw addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
        sw.on = _gestureOpen;
        [cell.contentView addSubview:sw];
    }
    if(indexPath.row != 0 && _gestureOpen){
        cell.textLabel.text = _data[indexPath.row - 1];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)swChange:(UISwitch *)sw{
    if(sw.isOn){
        SudokuViewController *vc = [[SudokuViewController alloc]init];
        vc.type = WTSudokuViewTypeSetting;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kGesture];
        _gestureOpen = NO;
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) return;
    SudokuViewController *vc = [[SudokuViewController alloc]init];
    if(indexPath.row == 1){
        vc.type = WTSudokuViewTypeSetting;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        vc.type = WTSudokuViewTypeVerity;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
