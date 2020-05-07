//
//  AudioTest.swift
//  TestMP3
//
//  Created by Don Mag on 5/7/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import Foundation
import AVFoundation

enum OutputType {
	case error
	case standard
}

class AudioTest {
	
	let consoleIO = ConsoleIO()

	var sound = AVAudioPlayer()

	func testMP3() -> Void {
		
		let bundle = Bundle.main
		let url = bundle.url(forResource: "files/this", withExtension: "mp3")
		if let u = url {
			
			do {
				sound = try AVAudioPlayer(contentsOf: u, fileTypeHint: AVFileType.mp3.rawValue)
				sound.prepareToPlay()
				sound.play()
			} catch let error {
				consoleIO.writeMessage(error.localizedDescription)
			}
			
		} else {
			consoleIO.writeMessage("Could not find resource!")
		}
		
	}
	
	func runTest() {
		
		testMP3()
		
		consoleIO.writeMessage("Type Q + Enter to Quit")

		var shouldQuit = false
		while !shouldQuit {
			let t = consoleIO.getInput()
			if t == "q" || t == "Q" {
				shouldQuit = true
			}
		}
	}

}

class ConsoleIO {
	
	func getInput() -> String {
		let keyboard = FileHandle.standardInput
		let inputData = keyboard.availableData
		let strData = String(data: inputData, encoding: String.Encoding.utf8)!
		return strData.trimmingCharacters(in: CharacterSet.newlines)
	}

	func writeMessage(_ message: String, to: OutputType = .standard) {
		switch to {
		case .standard:
			print("\(message)")
		case .error:
			fputs("Error: \(message)\n", stderr)
		}
	}

}
