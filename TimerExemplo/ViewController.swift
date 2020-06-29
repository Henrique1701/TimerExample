//
//  ViewController.swift
//  TimerExemplo
//
//  Created by José Henrique Fernandes Silva on 29/06/20.
//  Copyright © 2020 José Henrique Fernandes Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var seconds = 5 // Esta variável manterá um valor inicial de segundos. Pode ser qualquer valor acima de 0.
    var timer = Timer()
    var isTimerRunning = false // // Isso será usado para garantir que apenas um timer seja criado por vez. (Verifique se essa variável foi declarada na classe View Controller.)
    var resumeTapped = false
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60 // Aqui, inserimos manualmente o ponto de reinicialização dos segundos, mas seria mais sensato torná-lo uma variável ou constante.
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
        isTimerRunning = false
        
        self.pauseButton.isEnabled = false
        self.startButton.isEnabled = true
    }
    
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        self.pauseButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            // Enviar alerta para indicar que o tempo acabou!!
        } else {
            seconds -= 1 // Isso diminuirá (contagem regressiva) os segundos
            timerLabel.text = timeString(time: TimeInterval(seconds)) // Isso atualizará o rótulo
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pauseButton.isEnabled = false
    }


}

