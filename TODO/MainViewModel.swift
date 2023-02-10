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

    func defaultItems(_ items: String) {
        model.append(items)
    }
    
    func display(_ items: [String]) {
        model = items
    }
    
    func returnedItems() -> [String] {
        return model
    }
    
    func displayDetailView() {
        delegate?.goToDetatilView()
    }
}
