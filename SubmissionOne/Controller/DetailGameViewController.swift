//
//  DetailGameViewController.swift
//  SubmissionOne
//
//  Created by Ade Hendra on 25/08/21.
//  Copyright © 2021 Organisasi Berbudaya. All rights reserved.
//

import UIKit
import SDWebImage

class DetailGameViewController: UIViewController {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gamePhoto: UIImageView!
    @IBOutlet weak var gameRelease: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameCount: UILabel!
    @IBOutlet weak var gameMeta: UILabel!
    @IBOutlet weak var gameWeb: UILabel!
    @IBOutlet weak var gameDesc: UILabel!
    
    var idGame: Int?
    var detailGame: DetailGame?
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI {
            self.gameTitle.text = self.detailGame?.name
            self.gameRelease.text = self.detailGame?.released
            self.gameDesc.text = self.detailGame?.description
            self.gameRating.text = "\(self.detailGame!.rating)"
            self.gameCount.text = "\(self.detailGame!.ratingCount)"
            self.gameMeta.text = "\(self.detailGame!.metacritic)"
            self.gameWeb.text = self.detailGame?.website
            self.gamePhoto.sd_setImage(with: URL(string: self.detailGame!.backgroundImage), placeholderImage: UIImage(systemName: "photo"),context: nil)
            self.gamePhoto.contentMode = .scaleAspectFill
        }}
    func callAPI(completed : @escaping () ->())
    {
        let apiKey = "f0318ab9776b4fc5b2d072946236de4d"

        let components = URLComponents(string: "https://api.rawg.io/api/games/\(idGame!)?key=\(apiKey)")!
        let request = URLRequest(url: components.url!)

        func decodeJSON(data: Data) {
            let decoder = JSONDecoder()
            do{
                self.detailGame = try decoder.decode(DetailGame.self, from: data)
                DispatchQueue.main.async {
                    completed()
                }
            }
            catch
            {
                print("Error Json")
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }

            if response.statusCode == 200 {
                decodeJSON(data : data)
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }

}
