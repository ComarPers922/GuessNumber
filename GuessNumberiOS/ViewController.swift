//
//  ViewController.swift
//  GuessNumberiOS
//
//  Created by ComarPers 922 on 2016/11/5.
//  Copyright © 2016年 ComarPers 922. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //Show chances
    @IBOutlet weak var label_discription: UILabel!
    //User Input Textfield
    @IBOutlet weak var txt_userInput: UITextField!
    //Guess Action
    @IBOutlet weak var btn_guess: UIButton!
    //Restart
    @IBOutlet weak var btn_retry: UIButton!
    //Give user hints
    @IBOutlet weak var lab_hint: UILabel!
    
    private var chances = 5
    
    private var number:Int!//The number that user should guess

    //****************************Initialize
    func initializeGame()
    {
        let rand  = Int(arc4random())
        number = rand%101//Initialize the number
        
        chances = rand%8//Give user random chances
        if(chances<5)
        {
            chances = 5
        }
        showChances()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeGame()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(unfocusTextfield(_:)))
        self.view.addGestureRecognizer(tap)
    }
    //****************************
    
    //****************************Other functions
    func unfocusTextfield(_: UITapGestureRecognizer )
    {
        txt_userInput.resignFirstResponder()
    }
    
    func showChances()//Show how many chances do user have or show the answer if user failed
    {
         label_discription.text = "You have \(chances) chance\(chances <= 1 ? "" : "s")"
    }
    func loseChances(win:Bool)
    {
        if(win)
        {
            chances = 0
            showChances()
            label_discription.text = "The answer is \(number!)"
            return
        }
        chances-=1
        showChances()
        if(chances == 0)
        {
            label_discription.text = "The answer is \(number!)"
        }
    }
    //****************************
    
    
    //****************************UI Actions
    
    @IBAction func setValueToZero(_ sender: AnyObject)
    {
        if(txt_userInput.text!.isEmpty)
        {
            txt_userInput.text = "0"
        }
    }
    @IBAction func Retry(_ sender: AnyObject)
    {
        initializeGame()
        lab_hint.text = "Let the battle begin!"
    }

    @IBAction func Guess(_ sender: AnyObject)
    {
        if(txt_userInput.text!.isEmpty)
        {
            txt_userInput.text = "0"
        }//If there is no content in user input, set it to zero
        let userInput = Int(txt_userInput.text!)!
        if(chances<=0)
        {
            lab_hint.text = "Please click retry!"
            return
        }
        
        if(userInput<number)
        {
            lab_hint.text = "Your input is less than the number"
            loseChances(win:false)
        }
        else if(userInput>number)
        {
            lab_hint.text = "Your input is greater than the number"
            loseChances(win:false)
        }
        else
        {
            lab_hint.text = "Congradulations!"
            loseChances(win: true)
        }
    }
    //****************************
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

