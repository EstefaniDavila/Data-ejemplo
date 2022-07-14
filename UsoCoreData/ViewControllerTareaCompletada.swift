

import UIKit

class ViewControllerTareaCompletada: UIViewController {
    
    var tarea = Tarea()
    //var anteriorVC = ViewController()
    @IBOutlet weak var tareaLabel: UILabel!
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var final: UITextField!
    @IBOutlet weak var laboratorios: UITextField!
    @IBOutlet weak var practica: UITextField!
    @IBAction func completarTarea(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(tarea)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if tarea.importante{
            tareaLabel.text = "\(tarea.nombre!) :V"
        }else{
            tareaLabel.text = tarea.nombre
        }

        // Do any additional setup after loading the view.
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
