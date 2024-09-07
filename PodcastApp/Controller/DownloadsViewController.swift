//
//  DownloadsViewController.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import UIKit

private let reuseIdentifier = "DownloadCell"
class DownloadsViewController: UITableViewController {
    // MARK: - Properties
    private var episodeResult = UserDefaults.downloadEpisodeRead()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setNotificationCenter()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.episodeResult = UserDefaults.downloadEpisodeRead()
        tableView.reloadData()
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarController
        mainTabController.viewControllers?[2].tabBarItem.badgeValue = nil
    }
}
// MARK: - Selectors
extension DownloadsViewController{
    @objc private func handleDownload(notification: Notification){
        guard let response = notification.userInfo as? [String : Any] else { return }
        guard let title = response["title"] as? String else { return }
        guard let progressValue = response["progress"] as? Double else { return }
        guard let index = self.episodeResult.firstIndex(where: {$0.title == title}) else{ return }
        guard let cell = self.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? EpisodeCell else{ return }
        cell.progressView.isHidden = false
        cell.progressView.setProgress(Float(progressValue), animated: true)
        if progressValue >= 1{
            cell.progressView.isHidden = true
        }
    }
}
// MARK: - Helpers
extension DownloadsViewController{
    private func setNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownload), name: .downloadNotificationName, object: nil)
    }
    private func setup(){
        view.backgroundColor = .white
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
// MARK: - UITableViewDataSource
extension DownloadsViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        cell.episode = episodeResult[indexPath.item]
        return cell
    }
}
// MARK: - UITableViewDelegate
extension DownloadsViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PlayerViewController(episode: self.episodeResult[indexPath.item])
        self.present(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            UserDefaults.deleteDownloadedEpisode(episode: self.episodeResult[indexPath.item])
            self.episodeResult.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

