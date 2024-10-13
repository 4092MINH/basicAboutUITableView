//
//  VCSoundTable.swift
//  basicAboutUITableView
//
//  Created by Phan Nguyễn Khánh Minh on 13/10/24.
//

import UIKit
import AVFoundation

class VCSoundTable: UIViewController {
    var MTPSounds = ["Muộn rồi mà sao còn",
                    "Đừng làm trái tim anh đau",
                    "Chúng ta không thuộc về nhau",
                    "Nơi này có anh",
                    "Có chắc yêu là đây",
                    "Lạc trôi"]
    var MTPSoundsID = ["MTP0","MTP1","MTP2","MTP3","MTP4","MTP5"]
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var soundTable: UITableView!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var btnResetSound: UIButton!
    @IBOutlet weak var btnStopSound: UIButton!
    @IBOutlet weak var btnChangeVolume: UISlider!
    @IBOutlet weak var lblVolume: UILabel!
    @IBAction func PlayPauseSound(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            btnPlayPause.setTitle("Play Sound", for: .normal)
            btnPlayPause.tintColor = .green
        } else {
            audioPlayer.play()
            btnPlayPause.setTitle("Pause Sound", for: .normal)
            btnPlayPause.tintColor = .orange
        }
    }
    @IBAction func ResetSound(_ sender: UIButton) {
        audioPlayer.currentTime = 0
        audioPlayer.play()
        //audioPlayer.stop()
        //btnPlayPause.isHidden = true
        //btnResetSound.isHidden = true
        btnPlayPause.setTitle("Pause Sound", for: .normal)
        btnPlayPause.tintColor = .orange
    }
    
    @IBAction func StopSound(_ sender: UIButton) {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        btnPlayPause.isHidden = true
        btnResetSound.isHidden = true
        btnStopSound.isHidden = true
        btnChangeVolume.isHidden = true
        lblVolume.isHidden = true
    }
    
    @IBAction func volumeChange(_ sender: UISlider) {
        audioPlayer.volume = sender.value
        lblVolume.text = "Volume: \(Int(sender.value * 100))%"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        soundTable.delegate = self
        soundTable.dataSource = self
        btnPlayPause.isHidden = true
        btnResetSound.isHidden = true
        btnStopSound.isHidden = true
        btnChangeVolume.isHidden = true
        lblVolume.isHidden = true
    }
}
extension VCSoundTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 //MTPSounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MTPSounds[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        //print(MTPSounds[indexPath.row])
        guard let url = Bundle.main.url(forResource: MTPSoundsID[indexPath.row], withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("Can't play")
        }
        btnPlayPause.isHidden = false
        btnStopSound.isHidden = false
        btnResetSound.isHidden = false
        btnChangeVolume.isHidden = false
        lblVolume.isHidden = false
        btnPlayPause.setTitle("Pause Sound", for: .normal)
        btnPlayPause.tintColor = .orange
    }
}
