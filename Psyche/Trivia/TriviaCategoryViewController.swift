//
//  TriviaCategoryViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData

class TriviaCategoryViewController: UIViewController {

    //Opponent and Player outlets
    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var opponentBlurb: UILabel!
    
    //Category buttons
    @IBOutlet weak var scienceButton: UIButton!
    @IBOutlet weak var psycheButton: UIButton!
    @IBOutlet weak var nasaButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    
    //Opponent passed in through segue
    var opponent: Opponent?
    
    //Image chosen by user, will be updated in core date in viewDidLoad
    var profile_image = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve from coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TriviaInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            // This is a for loop but there should only be one object in core data
            for result in results as! [NSManagedObject] {
                // Get username
                if let username = result.value(forKey: "username") as? String {
                    profileName.text = username
                } else {
                    print("no username")
                }
                
                // Get avatar
                if let avatar = result.value(forKey: "avatar") as? Int {
                    profile_image = avatar
                } else {
                    print("no avatar")
                }
            }
        } catch {
            
        }
        
        //set player and opponent
        opponentAvatar.image = opponent?.unlockedImage
        if(profile_image == 1){
            profile.image = #imageLiteral(resourceName: "Asteroid_Large")
        }
        else if(profile_image == 2){
            profile.image = #imageLiteral(resourceName: "Earth_Large")
        }
        else if(profile_image == 3){
            profile.image = #imageLiteral(resourceName: "Moon_Large")
        }
        else if(profile_image == 4){
            profile.image = #imageLiteral(resourceName: "Saturn_Large")
        }
        else if(profile_image == 5){
            profile.image = #imageLiteral(resourceName: "Star_Large")
        }
        else if(profile_image == 6){
            profile.image = #imageLiteral(resourceName: "Sun_Large")
        }
        opponentName.text = opponent?.fname
        opponentBlurb.text = opponent?.blurb
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //different button segues
        if (segue.identifier == "psycheSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "psyche"
            psycheButton.setImage(#imageLiteral(resourceName: "GameCards_Psyche pressed"), for: .normal)
        }
        else if(segue.identifier == "scienceSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "science"
            scienceButton.setImage(#imageLiteral(resourceName: "GameCards_Science pressed"), for: .normal)
        }
        else if(segue.identifier == "nasaSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "nasa"
            nasaButton.setImage(#imageLiteral(resourceName: "GameCards_NASA pressed"), for: .normal)
        }
        else if (segue.identifier == "spaceSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "space"
            spaceButton.setImage(#imageLiteral(resourceName: "GameCards_Space pressed"), for: .normal)
        }
        
    }

}
