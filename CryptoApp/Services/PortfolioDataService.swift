//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/29/21.
//

import CoreData
import Foundation

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "Portfolio"
    
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Loading CoreData: \(error)")
            }
        }
        
        self.getPortfolio()
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { (savedEntity) in
            savedEntity.coinID == coin.id
        }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        }
        else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio from CoreData: \(error)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
