//
//  CountryViewController.m
//  CountryApp
//
//  Created by Sander on 29.03.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryViewController.h"
#import "DetailInfoController.h"
#import "AddInfoController.h"
#import "Country.h"
#import "Continent.h"
#import "CountryAppModel.h"

@interface CountryViewController () <UISearchBarDelegate, NSFetchedResultsControllerDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *filteredCountries;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CountryViewController

#pragma mark - View Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    self.navigationItem.leftBarButtonItem  = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    self.fetchedResultsController = [Country MR_fetchAllSortedBy:@"continent.title,title"
                                                       ascending:YES
                                                   withPredicate:nil
                                                         groupBy:@"continent.title"
                                                        delegate:self
                                                       inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return _fetchedResultsController;
    
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.filteredCountries) {
        return 1;
        
    } else {
        return [[self.fetchedResultsController sections] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.filteredCountries) {
        return nil;
        
    } else {
        return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectiontableView
{
    if (self.filteredCountries) {
        return self.filteredCountries.count;
        
    } else {
        NSInteger i = [[[self.fetchedResultsController sections] objectAtIndex:sectiontableView] numberOfObjects];
        return i;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Country *obj;
    
    if (self.filteredCountries) {
        obj = [self.filteredCountries objectAtIndex:indexPath.row];
    } else {
        obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
       
    }
    cell.textLabel.text       = obj.title;
    cell.detailTextLabel.text = [obj additionalInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    // for ios 8
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    // for ios 7
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (self.filteredCountries) {
            Country *countryObj = [self.filteredCountries objectAtIndex:indexPath.row];
            [countryObj MR_deleteEntity];
            [self.filteredCountries removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
      
        } else {
            
            [[NSManagedObjectContext MR_defaultContext] deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        }
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark - Delegate

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

#pragma mark - Helpers
/**
 *  showAlert method is example to remember how to create alertController (not call in code)
 *
 *  @param country show which country is selected
 */

- (void)showAlert:(NSString *)country
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                    message:[NSString stringWithFormat:@"You selected %@",country]
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cheel out"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (self.filteredCountries) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    if (self.filteredCountries) {
        return;
    }
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        case NSFetchedResultsChangeUpdate:
        
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
        break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    if (self.filteredCountries) {
        return;
    }
      UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (self.filteredCountries) {
        return;
    }
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure that segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"DetailPushSegue"]) {
        
        // Get indexPath from storyboard for selected cell
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Get reference to the destination view controller
        DetailInfoController *detailInfo = [segue destinationViewController];
            
        // Pass any objects to the view controller here, like...
        detailInfo.obj = self.filteredCountries ? [self.filteredCountries objectAtIndex:indexPath.row] : [self.fetchedResultsController objectAtIndexPath:indexPath];;
    }
}

#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([self.searchBar.text length] > 0) {
        [self doSearch];
    } else {
        self.filteredCountries = [[Country MR_findAll] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    // Clear search bar text
    self.searchBar.text = @"";
    self.filteredCountries = nil;
    // Hide the cancel button
    self.searchBar.showsCancelButton = NO;
    
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self doSearch];
}

- (void)doSearch
{
    // 1. Get the text from the search bar.
    NSString *searchText = self.searchBar.text;
    
    NSArray *countries = [self.fetchedResultsController fetchedObjects];
    self.filteredCountries = [NSMutableArray arrayWithArray:[countries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"title contains[c] %@", searchText]]];
    
    // 3. Reload the table to show the query results.
    [self.tableView reloadData];
}

@end