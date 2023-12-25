import UIKit
import WebKit

class PlayerViewController: UIViewController {
    
    var videoId: String?

    @IBOutlet weak var playerView: UIView!

    @IBOutlet weak var webPlayerView: WKWebView!
    //    var player: AVPlayer?
//    var playerViewController: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
//        playVideo()
        
        let youtubeURL = "https://www.youtube.com/embed/\(videoId ?? "")"

        // YouTube videosunu içeren URL'yi yükleyin
        let embedHTML = "<iframe width=\"100%\" height=\"100%\" src=\"\(youtubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"

        webPlayerView.loadHTMLString(embedHTML, baseURL: nil)
        
    }
    
//
//    func playVideo() {
//        guard let videoURL = URL(string: "https://www.youtube.com/watch?v=vsBwcxu8bAQ") else { return }
//        player = AVPlayer(url: videoURL)
//        playerViewController = AVPlayerViewController()
//        playerViewController?.player = player
//        playerView.addSubview(playerViewController!.view)
//        playerViewController?.view.frame = playerView.bounds
//        player?.volume = 1.0
//        player?.play()
//        playerViewController?.player?.play()    }
//
}


