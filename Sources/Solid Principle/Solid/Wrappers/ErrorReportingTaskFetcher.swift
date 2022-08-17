//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

#if canImport(UIKit)
import UIKit

final class ErrorReportingTaskFetcher: WorkPerforming {
    
    let controller: UIViewController
    let performer: WorkPerforming
    
    init(_ performer: WorkPerforming, controller: UIViewController) {
        self.performer = performer
        self.controller = controller
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        performer.perform { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                break
                
            case let .failure(error):
                self.show(error)
            }
            
            completion(result)
        }
    }
    
    private func show(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok!", style: .default))
        
        controller.present(alert, animated: true, completion: nil)
    }
}

#endif
