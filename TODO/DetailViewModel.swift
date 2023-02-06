import Foundation

protocol DetailViewModelProtocol: AnyObject {
    func getItems(_ item: String)
}

final class DetailViewModel {
    weak var delegate: DetailViewModelProtocol?
    
    func save(items: String) {
        delegate?.getItems(items)
    }
}
