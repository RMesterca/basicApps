import UIKit
import PlaygroundSupport

protocol ColorChooserDelegate{
    func selectedColor(color:Int)
}

//MARK: Step 1: define Data Source Protocol
//Usually: the difference between a data source and a delegate is delegates don't return values, they only take values in a parameter, while data sources return values.

protocol ColorChooserDataSource{
    func numberOfColors() -> Int
    func nameOfColor(for index:Int) -> String
    
//all of the responsibility of making the arrays work right will not fall to the class Colors, it'll fall to the class that's calling colors and used in adopting the data source.
    
    func colorOfColor(for index:Int) -> UIColor
}



class Colors{

//MARK: Step 2: just like delegates, declare data source of type Data Source Protocol

    var dataSource:ColorChooserDataSource! = nil
    var colorIndex = 0
    var colorName = ["red","green","blue","purple"]
    var color = [UIColor.red,UIColor.green,UIColor.blue,UIColor.purple]

//MARK: Step 3: in func name and color: instead of using internal, declare external colorIndex based on data source methods
    
    func name(_ index:Int) -> String{
       //return colorName[index % colorName.count]
       colorIndex = index % dataSource.numberOfColors()
        return dataSource.nameOfColor(for: colorIndex)
    }
    func color(_ index:Int) -> UIColor{
        //return color[index % color.count]
        colorIndex = index % dataSource.numberOfColors()
        return dataSource.colorOfColor(for: colorIndex)
    }
}
class ColorChooserVC:UIViewController, ColorChooserDataSource {
    
/* MARK: Step 4: since Colors no longer has any responsibility for the data (just reading and processing data), colorName and color are redundant and they also need to be in ColorChooserVC and View Controller (classes that implement ColorChooserDataSource Protocol).
     
     Adopt Data Source Protocol if already didn't and implement protocol stubs*/

    var colorName = ["red","green","blue","purple"]
    var color = [UIColor.red,UIColor.green,UIColor.blue,UIColor.purple]
    var colors = Colors()
    var currentColor = 0
    var delegate:ColorChooserDelegate! = nil
    @IBAction func chooser(sender:UISegmentedControl){
        currentColor = sender.selectedSegmentIndex
        view.backgroundColor = colors.color(currentColor)
        delegate.selectedColor(color: currentColor)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {

//    MARK: Step 6: Important!! do not forget to assign the dataSource (delegate has value nil in the Destination Controller)
        
        colors.dataSource = self
        let chooser = UISegmentedControl(items: colors.colorName)
        chooser.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        chooser.addTarget(self, action: #selector(chooser(sender:)), for: .valueChanged)
        chooser.tintColor = UIColor.black
        view.addSubview(chooser)
        view.backgroundColor = colors.color(currentColor)
    }
   
/*MARK: Step 5: implement protocol methods*/
    
    
    // Delegates and data sources
    func numberOfColors() -> Int {
        return colorName.count
    }
    
    func nameOfColor(for index: Int) -> String {
        return colorName[index]
    }
    
    func colorOfColor(for index: Int) -> UIColor {
        return color[index]
    }
}

class ViewController:UIViewController, ColorChooserDelegate, ColorChooserDataSource{
    
/* MARK: Step 4: since Colors no longer has any responsibility for the data (just reading and processing data), colorName and color are redundant and they also need to be in ColorChooserVC and View Controller (classes that implement ColorChooserDataSource Protocol).
     
     Adopt Data Source Protocol if already didn't and implement protocol stubs */

    var colorName = ["red","green","blue","purple"]
    var color = [UIColor.red,UIColor.green,UIColor.blue,UIColor.purple]
    func selectedColor(color: Int) {
        count = color
        view.backgroundColor = colors.color(color)
    }
    
    var count = 0
    var colors = Colors()
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
    @IBAction func changeColor(sender:UIButton){
        //count += 1
        //view.backgroundColor = colors.color(count % colors.colorName.count)
        let vc = ColorChooserVC()
        vc.currentColor = count
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
//    MARK: Step 6: Important!! do not forget to assign the dataSource (delegate has value nil in the Destination Controller)
        colors.dataSource = self
        view.backgroundColor = UIColor.orange
        button.setTitle("Color Choice", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.addTarget(self, action: #selector(changeColor(sender:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
/*MARK: Step 5: implement protocol methods*/
    
    // Delegates and data sources
    func numberOfColors() -> Int {
        return colorName.count
    }
    
    func nameOfColor(for index: Int) -> String {
        return colorName[index]
    }
    
    func colorOfColor(for index: Int) -> UIColor {
        return color[index]
    }
    
}


//let colors = Colors()
//let myColor = colors.color(1)

//let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
PlaygroundPage.current.liveView = ViewController()














