//
//  ViewController.swift
//  SubmissionOne
//
//  Created by Ade Hendra on 24/08/21.
//  Copyright © 2021 Organisasi Berbudaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameTableView: UITableView!
    var games = Games(count: 0, seoTitle: "", games: [Game]())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Popular Games"
        callAPI {
            self.gameTableView.reloadData()
        }
        gameTableView.dataSource = self
        gameTableView.delegate = self
        gameTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    func callAPI(completed : @escaping () -> Void){   let apiKey = "f0318ab9776b4fc5b2d072946236de4d"
        let page = "10"
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        components.queryItems = [
            URLQueryItem(name: "page_size", value: page),
            URLQueryItem(name: "key", value: apiKey)]
        let request = URLRequest(url: components.url!)
        func decodeJSON(data: Data) {
            let decoder = JSONDecoder(); do {
                self.games = try decoder.decode(Games.self, from: data)
                DispatchQueue.main.async{
                    completed()
                    }}
            catch{
                print("Error Json")
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200   {decodeJSON(data : data)} else {
                print("ERROR: \(data) \(error!), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell {
            let gameListed = games.games[indexPath.row]
            cell.nameGame.text = gameListed.name
            cell.ratingGame.text = "\(gameListed.rating)"
            cell.releaseDate.text = gameListed.released
            cell.photoGame.sd_setImage(with: URL(string: gameListed.backgroundImage), placeholderImage: UIImage(systemName: "photo"), context: nil)
            cell.photoGame.contentMode = .scaleAspectFill
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailGameViewController(nibName: "DetailGameViewController", bundle: nil)
        detail.idGame = games.games[indexPath.row].id
        self.navigationController?.pushViewController(detail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

