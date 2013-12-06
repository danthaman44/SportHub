//
//  PrivateSearchViewController.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/6/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "PrivateSearchViewController.h"
#import "Game.h"
#import "LoggedInUser.h"
#import "CJSONDeserializer.h"

@interface PrivateSearchViewController ()

@end

@implementation PrivateSearchViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    NSString *serverAddress = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/see_games"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"POST"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSError *theError = nil;
    NSArray* jsonData = [[CJSONDeserializer deserializer] deserialize:response error:&theError];
    NSMutableArray* tempPrivateGames = [[NSMutableArray alloc] init];
    if ([jsonData count] > 0) {
        for (NSArray* object in jsonData) {
            Game *g1 = [[Game alloc] init];
            NSMutableArray *playersTemp = [[NSMutableArray alloc] init];
            if([object objectAtIndex:7] != nil) {
                for (NSString* player in [object objectAtIndex:7]) {
                    [playersTemp addObject:player];
                }
            }
            g1.players = playersTemp;
            g1.gid = [[object objectAtIndex:6] intValue];
            g1.numPlayers = 3;
            g1.location = [object objectAtIndex:1];
            NSString *str =[object objectAtIndex:2];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [formatter dateFromString:str];
            g1.time = date;
            g1.sport = [object objectAtIndex:3];
            g1.isPrivate = [object objectAtIndex:5];
            g1.numPlayers = [[object objectAtIndex:4] intValue];
            
            if([g1.isPrivate isEqualToString:@"True"])
                [tempPrivateGames addObject:g1];
        }
    }
    self.privateGames = [NSArray arrayWithArray:tempPrivateGames];
}

-(IBAction)privateGameSearch:(id)sender {
    for(Game* game in self.privateGames) {
        if(game.gid == [self.privateSearch.text intValue]) {
            NSString *queryString = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/join_game"];
            NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                             requestWithURL:[NSURL URLWithString:
                                                             queryString]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:60.0];
            [theRequest setHTTPMethod:@"POST"];
            NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:[LoggedInUser getInstance].username, @"Username", self.privateSearch.text, @"GameId", nil];
            NSError *error=nil;
            
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                               options:NSJSONWritingPrettyPrinted error:&error];
            
            
            [theRequest setHTTPBody:jsonData];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            if([returnString isEqualToString:@"Success"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've joined the game!"
                                                                message:@"Aren't you special"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

-(IBAction)resignFirst:(id)sender {
    [sender resignFirstResponder];
}

@end
