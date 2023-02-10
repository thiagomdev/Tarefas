import Foundation

protocol DetailViewModelProtocol: AnyObject {
    func getItems(_ item: String)
}

final class DetailViewModel {
    weak var delegate: DetailViewModelProtocol?
    
    private var items: String?
    
    var showAlert: (() -> Void)?
    var back: (() -> Void)?
    
    func displayResult(items: String) {
        if items.isEmpty {
            showAlert?()
        } else {
            delegate?.getItems(items)
            back?()
        }
    }
}
