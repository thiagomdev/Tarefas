import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    
    private lazy var addTaskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adicionar tarefas"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar", for: .normal)
        button.addTarget(self, action: #selector(didAddItemButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func didAddItemButton() {
        guard let items = addTaskTextField.text else  { return }
        showAlert()
        pop()
        viewModel.displayResult(items: items)
    }
    
    private func showAlert() {
        viewModel.showAlert = { [weak self] in
            let alert = UIAlertController(title: "Hey!!\n🤭", message: "VOCÊ PRECISA ADICIONAR,\nTAREFAS NA LISTA.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    private func pop() {
        viewModel.back = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailViewController: ViewConfiguration {
    func buildHierarchyView() {
        view.addSubview(addTaskTextField)
        view.addSubview(addItemButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addTaskTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            addTaskTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: addTaskTextField.trailingAnchor, multiplier: 3),
            
            addItemButton.topAnchor.constraint(equalToSystemSpacingBelow: addTaskTextField.bottomAnchor, multiplier: 2),
            addItemButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: addItemButton.trailingAnchor, multiplier: 3),
        ])
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
