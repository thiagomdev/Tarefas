import Foundation

protocol MainViewModelProtocol: AnyObject {
    func goToDetatilView()
}

final class MainViewModel {
    var model: TodoModel
    
    weak var delegate: MainViewModelProtocol?
    
    var count: Int {
        return model.items.count
    }
    
    var items: [String] {
        return model.items
    }
    
    init(model: TodoModel) {
        self.model = model
    }
    
    func getItems(_ items: String) {
        model.items.append(items)
    }
    
    func displayDetailView() {
        delegate?.goToDetatilView()
    }
}
