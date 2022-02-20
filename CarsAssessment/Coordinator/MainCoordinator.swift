//
//  MainCoordinator.swift
//  NYTimesTask
//
//  Created by AboNabih on 1/9/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vcontroller = MakesViewController.instantiate(storyboardName: Constants.StoryBoardIDs.MakesScene)
        vcontroller.coordinator = self
        navigationController.show(vcontroller, sender: nil)
    }
    func showModels(make: Make) {
        let vcontroller = ModelsViewController.instantiate(storyboardName: Constants.StoryBoardIDs.ModelsScene)
        vcontroller.coordinator = self
        vcontroller.viewModel.make = make
        navigationController.show(vcontroller, sender: nil)
    }
}
