import Foundation

protocol MainViewModelProtocol: AnyObject {
    func goToDetatilView()
}

final class MainViewModel {
    private var model: [String]
    weak var delegate: MainViewModelProtocol?
    
    init(model: [String]) {
        self.model = model
    }
    
    var count: Int {
        return model.count
    }
    
    func remove(at index: IndexPath) {
        model.remove(at: index.row)
    }

    func getItems(_ items: String) {
        model.append(items)
    }
    
    func displayDetailView() {
        delegate?.goToDetatilView()
    }
    
    func display(_ items: [String]) {
        model = items
    }
    
    func returnedItems() -> [String] {
        return model
    }
}
