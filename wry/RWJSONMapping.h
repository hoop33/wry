//
//  RWJSONMapping.h
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface RWJSONMapping : NSObject

@property(nonatomic, strong) Class cls;
@property(nonatomic, strong) NSMutableArray *arrayMappings;
@property(nonatomic, strong) NSMutableDictionary *dictionaryMappings;
@property(nonatomic, strong) NSMutableDictionary *relationshipMappings;
@property(nonatomic, strong) NSMutableDictionary *listMappings;

- (id)initWithClass:(Class)cls;
- (void)addAttributeMappingsFromArray:(NSArray *)array;
- (void)addAttributeMappingsFromDictionary:(NSDictionary *)dictionary;
- (void)addRelationshipMappingWithSourceKeyPath:(NSString *)sourceKey mapping:(RWJSONMapping *)mapping;
- (void)addListMappingWithSourceKeyPath:(NSString *)sourceKey mapping:(RWJSONMapping *)mapping;

@end
