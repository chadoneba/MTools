import UIKit
import CoreData

public class DataController: NSObject {

    static let instance = DataController()
    
    
    public static var Storage:DataController {
        get {
            return instance
        }
    }
    
    public var managedObjectContext: NSManagedObjectContext?
    private var storageName = "default"
    
    public func setStorageName(name:String) {
        self.storageName = name
    }
    
    public func start() {
    
    guard let modelURL = Bundle.main.url(forResource: storageName, withExtension:"momd") else {
    fatalError("Error loading model from bundle")
    }
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
    fatalError("Error initializing mom from: \(modelURL)")
    }
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    
    self.managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.managedObjectContext?.persistentStoreCoordinator = psc
    
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docURL = urls[urls.endIndex-1]
    /* The directory the application uses to store the Core Data store file.
     This code uses a file named "DataModel.sqlite" in the application's documents directory.
     */
    let storeURL = docURL.appendingPathComponent("\(storageName).sqlite")
    do {
    try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    } catch {
    fatalError("Error migrating store: \(error)")
    }
    }

}
