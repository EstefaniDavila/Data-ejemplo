
import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tareas:[Tarea] = []
    var pract = 0.0
    var lab = 0.0
    var exam = 0.0
    //var indexSeleccionado = 0
    
    @IBAction func agregarTarea(_ sender: Any) {
        performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let tarea = tareas[indexPath.row]
        pract = Double(tarea.practicas!)!
        lab = Double(tarea.laboratorios!)!
        exam = Double(tarea.examen!)!
        if (((pract+lab+exam)/3)>=13){
            cell.textLabel?.text = tarea.nombre!
            cell.backgroundColor = UIColor.green
        }else{
            cell.textLabel?.text = tarea.nombre!
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func obtenerTareas(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tareas = try context.fetch(Tarea.fetchRequest()) as! [Tarea]
        }catch{
            print("Error al leerentidad de CoreData")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "agregarSegue"{
            let siguienteVC = segue.destination as! ViewControllerCrearTarea
            siguienteVC.anteriorVC = self
        }else*/
        if(segue.identifier == "tareaSeleccionadaSegue"){
            let siguienteVC = segue.destination as! ViewControllerTareaCompletada
            siguienteVC.tarea = sender as! Tarea
            //siguienteVC.anteriorVC = self
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexSeleccionado = indexPath.row
        let tarea = tareas[indexPath.row]
        performSegue(withIdentifier: "tareaSeleccionadaSegue", sender: tarea)
    }

    override func viewWillAppear(_ animated: Bool) {
        obtenerTareas()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        //tareas = crearTareas()
}
    func tableView( tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
            return true
        }
        func tableView( tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
            forRowAt indexPath: IndexPath){
           if editingStyle == .delete{
                tareas.remove(at: indexPath.row)
                tableView.reloadData()
            }else if editingStyle == .insert{
        }
    }

}
