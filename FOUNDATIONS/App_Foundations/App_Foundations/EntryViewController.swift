//
//  EntryViewController.swift
//  App_Foundations
//
//  Created by Maria Vitoria Soares Muniz on 22/11/21.
//


// aqui terá um campo onde o usuário pode inserir uma nova tarefa
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - PROPERTIES
    
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet var field: UITextField!
    @IBOutlet weak var MinuteInput: UITextField!
    @IBOutlet weak var HourInput: UITextField!
    
    @IBOutlet weak var ImpactSliderInput: UISlider!
    @IBOutlet weak var UrgencySliderInput: UISlider!
    @IBOutlet weak var ComplexitySliderInput:UISlider!
    
    @IBOutlet weak var ImpactLabel:UILabel!
    @IBOutlet weak var UrgencyLabel:UILabel!
    @IBOutlet weak var ComplexityLabel:UILabel!
    
    
    @IBOutlet weak var ButtonSalve: UIButton!
    

    
    var tempTask: Task?
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonSalve.layer.cornerRadius = 10
        field.delegate = self
    }
    
    
    
    //MARK: - FUNCTIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(ImpactSliderInput.value, UrgencySliderInput.value, ComplexitySliderInput.value)
        
        guard let name = field.text, !name.isEmpty else{ return }
        guard let DescriptionText = DescriptionTextField.text, !DescriptionText.isEmpty else{ return }
        guard let hourText = HourInput.text, !hourText.isEmpty else { return }
        guard let minuteText = MinuteInput.text, !minuteText.isEmpty else { return }
        guard var impactValue = ImpactSliderInput?.value, !impactValue.isNaN else { return }
        
        if (impactValue == 0) {
            impactValue = 1
        }
        
        guard var urgencyValue = UrgencySliderInput?.value, !urgencyValue.isNaN else { return }
        
        if (urgencyValue == 0) {
            urgencyValue = 1
        }
        
        guard var complexityValue = ComplexitySliderInput?.value, !complexityValue.isNaN else { return }
        
        if (complexityValue == 0) {
            complexityValue = 1
        }
        
        
        tempTask = Task(name: name, description: DescriptionText, hour: hourText, minute: minuteText, isMarked: false, impact: impactValue, urgency: urgencyValue, complexity: complexityValue)
        
        print(tempTask)
        
        let destinationVC = segue.destination as? UINavigationController
        let nextViewController = destinationVC?.viewControllers[0] as? ViewController
        guard let task = tempTask else {return}
        //        print(task.name)
        nextViewController?.tasks.append(task)
    }
    
    
    //MARK: - ACTIONS

    @IBAction func impactSliderValueChanged(_ sender: UISlider) {
        
        // Get slider value Float type.
        let sliderValue:Float = ImpactSliderInput.value
        
        // Cast Float type value to Int type.
        let ImpactSliderValueInt:Int = Int(sliderValue)
        
        // Set the Int type value to label text.
        ImpactLabel.text = String(ImpactSliderValueInt)
    }
    
    @IBAction func urgencySliderValueChanged(_ sender: UISlider) {
        
        // Get slider value Float type.
        let sliderValue:Float = UrgencySliderInput.value
        
        // Cast Float type value to Int type.
        let UrgencySliderValueInt:Int = Int(sliderValue)
        
        // Set the Int type value to label text.
        UrgencyLabel.text = String(UrgencySliderValueInt)
    }
    
    @IBAction func complexitySliderValueChanged(_ sender: UISlider) {
        
        // Get slider value Float type.
        let sliderValue:Float = ComplexitySliderInput.value
        
        // Cast Float type value to Int type.
        let ComplexitySliderValueInt:Int = Int(sliderValue)
        
        // Set the Int type value to label text.
        ComplexityLabel.text = String(ComplexitySliderValueInt)
    }
    

}
