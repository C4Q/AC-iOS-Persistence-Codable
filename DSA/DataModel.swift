//
//  DataModel.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import Foundation

class DataModel {
    
    static let kPathname = "DSAListCodable.plist"
    
    // using a singleton to manage the model
    private init(){}
    static let shared = DataModel()
    
    private var lists = [DSA]() {
        didSet { // property observer does saving to persistence on changes
            saveDSAList()
        }
    }
    
    // returns documents directory path for app sandbox
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // returns the path for supplied name from the dcouments directory
    private func dataFilePath(withPathName path: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(path)
    }
    
    // save
    private func saveDSAList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(withPathName: DataModel.kPathname), options: .atomic)
        } catch {
            print("error encoding items: \(error.localizedDescription)")
        }
    }
    
    // load 
    public func load() {
        let path = dataFilePath(withPathName: DataModel.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            lists = try decoder.decode([DSA].self, from: data)
        } catch {
            print("error decoding items: \(error.localizedDescription)")
        }
    }
    
    // create
    public func addDSAItemToList(dsaItem item: DSA) {
        lists.append(item)
    }
    
    // read
    public func getLists() -> [DSA] {
        return lists
    }
    
    // update
    public func updateDSAItem(withUpdatedItem item: DSA) {
        if let index = lists.index(where: {$0 === item}) { 
            lists[index] = item
        }
    }
    
    // delete
    public func removeDSAItemFromIndex(fromIndex index: Int) {
        lists.remove(at: index)
    }
}
