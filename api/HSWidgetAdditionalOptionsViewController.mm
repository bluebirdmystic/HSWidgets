#import "HSWidget-Availability.h"
#import "HSWidgetAdditionalOptionsViewController.h"
#import "HSWidgetAvailablePositionObject.h"
#import "HSWidgetViewController.h"

@implementation HSWidgetAdditionalOptionsViewController
-(instancetype)initWithWidgetsOptionsToExclude:(NSArray *)optionsToExclude withDelegate:(id<HSWidgetAddNewAdditionalOptionsDelegate>)delegate availablePositions:(NSArray<HSWidgetAvailablePositionObject *> *)positions {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"
	self = [super initWithStyle:isAtLeastiOS13() ? UITableViewStyleInsetGrouped : UITableViewStyleGrouped];
#pragma clang diagnostic pop
	if (self != nil) {
		self.delegate = delegate;
		self.widgetClass = nil;
		self.widgetOptions = [NSMutableDictionary dictionary];
		self.requestWidgetSize = HSWidgetSizeZero;
		self.availablePositions = positions;
	}
	return self;
}

-(void)viewDidLoad {
	[super viewDidLoad];

	// hide the scroll indicators
	[self.tableView setShowsHorizontalScrollIndicator:NO];
	[self.tableView setShowsVerticalScrollIndicator:NO];

	if ([self.widgetClass isSubclassOfClass:[HSWidgetViewController class]]) {
		self.navigationItem.title = [self.widgetClass widgetDisplayInfo][HSWidgetDisplayNameKey];
	}
}

-(void)cancelAdditionalOptions {
	// perform actions when additional options is cancelled
	[self.delegate dismissAddWidget];
}

-(void)addWidget {
	// perform actions when additional options is added/done
	[self.delegate additionalOptionsViewController:self addWidgetForClass:self.widgetClass];
}

-(BOOL)containsSpaceForGridPositions:(NSArray<HSWidgetPositionObject *> *)positions {
	return [HSWidgetGridPositionConverterCache canFitWidget:positions inGridPositions:self.availablePositions];
}

-(BOOL)containsSpaceForWidgetSize:(HSWidgetSize)size {
	return [HSWidgetGridPositionConverterCache canFitWidgetOfSize:size inGridPositions:self.availablePositions];
}

-(void)dealloc {
	self.delegate = nil;
	self.widgetClass = nil;
	self.widgetOptions = nil;
	self.availablePositions = nil;

	[super dealloc];
}
@end