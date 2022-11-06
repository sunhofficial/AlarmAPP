//
//  ViewController.swift
//  AlarmAPP
//
//  Created by SunHo Lee on 2022/11/03.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let datePicker = UIDatePicker()
    private let btnalarm = UIButton(
        frame: CGRect(x: 100, y: 19, width: 50, height: 40))
    lazy var whatTodo = UITextField()
    var nowTime = UILabel()
    private var alarmTable : UITableView!
    var todolist : [[String]] = [] {
        didSet{
            alarmTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setTitle()
        setDate()
        setTable()
        RingAlarm()
        self.view.addSubview(nowTime    )
        nowTime.snp.makeConstraints{
            $0.top.equalTo(btnalarm).offset(40)
        }
    }
    private func setTitle() {
        let image = UIImage(named: "logo")
        let imageV = UIImageView(image: image)
        imageV.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        imageV.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageV
        
    }
    private func setTable() {
        alarmTable = UITableView(frame: CGRect(x: 0, y: 300, width: self.view.frame.height, height: self.view.frame.width))
        alarmTable.register(TTAB.self, forCellReuseIdentifier: TTAB.identifier)
        alarmTable.delegate = self
        alarmTable.dataSource = self
        self.view.addSubview(alarmTable)
    }
    private func setDate() {
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .automatic
        btnalarm.setTitle("알람추가하기", for: .normal)
        btnalarm.backgroundColor = .gray
        btnalarm.addTarget(self, action: #selector(addalarm), for: .touchUpInside)
        whatTodo.placeholder = "할일을 기록해주세요"
        whatTodo.backgroundColor = .placeholderText
        //        self.whatTodo.delegate = self
        view.addSubview(btnalarm)
        view.addSubview(datePicker)
        view.addSubview(whatTodo)
        datePicker.snp.makeConstraints{
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
        }
        whatTodo.snp.makeConstraints{
            $0.top.equalTo(datePicker).inset(50)
            $0.centerX.equalToSuperview()
        }
        btnalarm.snp.makeConstraints{
            $0.top.equalTo(whatTodo).inset(50)
            $0.centerX.equalToSuperview()
        }
    }
    private func RingAlarm(){
        DispatchQueue.global(qos: .background).async{
            Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.findtime), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
        
    }
    @objc func findtime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE hh:mm"
        let showdate = formatter.string(from: date as Date)
        DispatchQueue.main.async {
            self.nowTime.text = showdate
        }
            
        
        let count = self.todolist.count
        for i in 0..<count{
            if(todolist[i][1] == showdate){
                DispatchQueue.main.async {
                    self.view.backgroundColor = .red
                    let alert = UIAlertController(title: "알람이 울립니다", message: self.todolist[i][0], preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(ok)
                    self.present(alert,animated: true)
                    
                }
            }
            else{
                DispatchQueue.main.async {
                    self.view.backgroundColor = .white
                }
            }
        }
        
    }
    @objc func addalarm(sender: UIButton!) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd EEE hh:mm"
        let date = dateformatter.string(from: datePicker.date)
        guard let whattodo = whatTodo.text else { return}
        todolist.append([whattodo,date])
    
        

    }

}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TTAB.identifier, for: indexPath) as! TTAB
        cell.label.text = todolist[indexPath.row][0]
        cell.dateLabel.text = todolist[indexPath.row][1]

        return cell
    }
}

