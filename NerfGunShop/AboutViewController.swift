//
//  AboutViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 23/2/22.
//

import UIKit
import AVFoundation

class AboutViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet var ackLbl: UILabel!
    @IBOutlet var logoImg: UIImageView!
    var easter: AVAudioPlayer?
    var isPlaying = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ackLbl.text = "The NERF brand and its terms belongs to Hasbro\nThe X-Shot brand and its terms belongs to Zuru .Inc\n\nProduct images taken from Toy'R'Us\n\nApp icon generated with AndroidAssetStudio\nhttps://romannurik.github.io/AndroidAssetStudio/"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func easterClick(_ sender: Any) {
        if !isPlaying {
            guard let audioData = NSDataAsset(name: "Keygen Music - AGAiN - FairStars MP3 Recorder")?.data else {
                fatalError("Asset not found")
            }

            do {
                easter = try AVAudioPlayer(data: audioData)
                easter?.delegate = self
                easter?.play()
                isPlaying = true
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func emailBtn(_ sender: Any) {
        if let url = URL(string: "mailto:facebooklee52@gmail.com?subject=Question%20for%20Kangaroo%20Shop") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }

    }
    
    @IBAction func sourceBtn(_ sender: Any) {
        if let url = URL(string: "https://github.com/josephlee222/NerfGunShop") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
