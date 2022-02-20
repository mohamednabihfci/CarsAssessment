//
//  ModelsCellViewModel.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class ModelsCellViewModel {
    var titleTxt = BehaviorRelay<String>(value: "")
    var backgroundImg = BehaviorRelay<String>(value: "")
    var modelsClient = ModelsClient()
    private let disposeBag = DisposeBag()
    let appDelegate =
      UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext!
    init(item: Model) {
        managedContext =
          appDelegate.persistentContainer.viewContext
        titleTxt.accept(item.niceName ?? "")
        load(model: item)
    }
    func load(model: Model) {
        if !checkIfItemExist(id: model.id ?? "").isEmpty {
            self.prepareImage(url: checkIfItemExist(id: model.id ?? ""))
        } else {
        modelsClient.getPhotos(model: model).subscribe(onNext: { [weak self] (photos) in
            guard let img = photos.photos.first, let link = img.sources?.first else {return}
            let url = Constants.APIS.MEEDIAURL + link.link.href
                self?.prepareImage(url: url)
                self?.save(modelID: model.id ?? "", photoUrl: url)
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
        }
    }
    func prepareImage(url: String) {
        backgroundImg.accept(url)
    }
    func save(modelID: String, photoUrl: String) {
      let entity =
        NSEntityDescription.entity(forEntityName: "ModelsUrls",
                                   in: managedContext)!
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      person.setValue(modelID, forKeyPath: "id")
      person.setValue(photoUrl, forKeyPath: "url")
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    func checkIfItemExist(id: String) -> String {
        let managedContext =
          appDelegate.persistentContainer.viewContext
        var url = ""
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ModelsUrls")
          fetchRequest.fetchLimit = 1
          fetchRequest.predicate = NSPredicate(format: "id == %@", id)
          let cached = try managedContext.fetch(fetchRequest) as? [ModelsUrls] ?? []
            url = cached.first.map {$0.url ?? ""} ?? ""
        } catch {
        }
        return url
    }
}
