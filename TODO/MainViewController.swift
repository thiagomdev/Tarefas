import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .systemBackground
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(viewModel: MainViewModel) {
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
    private func addItemPressed() {
        viewModel.displayDetailView()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        cell?.selectionStyle = .none
        cell?.setup(from: viewModel.returnedItems()[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DispatchQueue.main.async {
                self.viewModel.remove(at: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .bottom)
                UserDefaults.standard.set(self.viewModel.returnedItems(), forKey: "items")
                self.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: DetailViewModelProtocol {
    func getItems(_ item: String) {
        DispatchQueue.main.async {
            var currentItem = UserDefaults.standard.stringArray(forKey: "items") ?? []
            currentItem.append(item)
            UserDefaults.standard.set(currentItem, forKey: "items")
            self.viewModel.defaultItems(item)
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: MainViewModelProtocol {
    func goToDetatilView() {
        let detailViewModel = DetailViewModel()
        let detaiView = DetailViewController(viewModel: detailViewModel)
        detailViewModel.delegate = self
        navigationController?.pushViewController(detaiView, animated: true)
    }
}

extension MainViewController: ViewConfiguration {
    func buildHierarchyView() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureUI() {
        title = "Tarefas"
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addItemPressed))
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        viewModel.display(UserDefaults.standard.stringArray(forKey: "items") ?? [])
    }
}
