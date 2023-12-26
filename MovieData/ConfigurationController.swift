//
//  ConfigurationController.swift
//  MovieData
//
//  Created by Anthony Santiago on 05/12/23.
//

import Foundation

final class ConfigurationController {
    
    let configurationNetWork = ConfigurationNetworkManager()
    var config: ConfigurationModel?
    
    init() {
        configurationNetWork.getApiConfiguration { [self] result in
            switch result {
            case .success(let success):
                self.config = success
            case .failure(_):
                self.config = nil
            }
        }
    }
}
