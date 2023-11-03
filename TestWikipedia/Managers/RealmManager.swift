//
//  RealmManager.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import RealmSwift

protocol ObjectCodableProtocol: Object, Codable {}

var realmDB: Realm {
    let queue = DispatchQueue(label: "RealmQueue")
    var realm: Realm!
    queue.sync {
        realm = RealmOwner.instance.realm
    }
    return realm
}

class RealmOwner {
    fileprivate static var instance = RealmOwner()
    
    fileprivate var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            print("Realm Error: \(error.localizedDescription)")
            fatalError("Failed to initialize Realm")
        }
    }
    
    fileprivate init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 0) {
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
}

extension Realm {
    
    func isRealmEmpty() -> Bool {
        return realmDB.isEmpty
    }
    
    func isEntityEmpty<Entity: Object>(_ objectType: Entity.Type) -> Bool {
        return readAllObjects(objectType)?.isEmpty ?? true
    }
    
    func safeWrite(_ block: (() -> Void)?) {
        if isInWriteTransaction {
            block?()
        } else {
            do {
                try write {
                    block?()
                }
            } catch {
                print("Error writing to Realm: \(error.localizedDescription)")
            }
        }
    }
    
      
    //MARK: - Read
    func readAllObjects<Entity: Object>(_ objectType: Entity.Type) -> Results<Entity>? {
        return realmDB.objects(objectType)
    }
    

    //MARK: - Update
    func updateObjects<Entity: Object>(_ objects: [Entity]) {
        safeWrite {
            for object in objects {
                realmDB.add(object, update: .modified)
            }
        }
    }
    
    func updateObject<Entity: Object>(_ object: Entity) {
        safeWrite {
            realmDB.add(object, update: .modified)
        }
    }
    
    //MARK: - Delete
    func deleteObject<Entity: Object>(_ object: Entity) {
        safeWrite {
            realmDB.delete(object)
        }
    }
    
    // Delete All Data from Realm
    func deleteAllDataFromRealm() {
        safeWrite {
            realmDB.deleteAll()
        }
    }
    
    // Delete All Objects of Specific Types
    func deleteAllObjectsOfTypes<Entity: Object>(_ types: [Entity.Type]) {
        safeWrite {
            for type in types {
                let objects = realmDB.objects(type)
                realmDB.delete(objects)
            }
        }
    }
}
