//
//  ViewController.swift
//  AlarmAPP
//
//  Created by SunHo Lee on 2022/11/03.
//

import UIKit
import Lottie
import SnapKit

class ViewController: UIViewController {
    private let datePicker = UIDatePicker()
    var showtable = true
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
    let circlebtn : UIView = UIView()
    let rectbtn : UIView = UIView()
//        let view = UIView()
//        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(eraseeeee))
//        rectbtn.addGestureRecognizer(tapgesture)
//        rectbtn.isUserInteractionEnabled = true
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setTitle()
        setDate()
        setTable()
        RingAlarm()
        setclearBtn()
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
        alarmTable = UITableView(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: self.view.frame.height/2))
        alarmTable.register(TTAB.self, forCellReuseIdentifier: TTAB.identifier)
        alarmTable.delegate = self
        alarmTable.dataSource = self
        alarmTable.layer.cornerRadius = 5
        alarmTable.layer.borderWidth = 2
        alarmTable.layer.borderColor = UIColor.brown.cgColor
        self.view.addSubview(alarmTable)
        alarmTable.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-170)
            $0.top.equalTo(btnalarm.snp.bottom).offset(40)
        }
      
        guard let datas = UserDefaults.standard.object(forKey: "datasave") as? [[String]] else {return}
        todolist = datas
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
    private func setclearBtn(){
        
        circlebtn.layer.cornerRadius = 50
        circlebtn.layer.shadowRadius = 6
        circlebtn.layer.backgroundColor = UIColor.black.cgColor
  
        self.view.addSubview(circlebtn)
        self.view.addSubview(rectbtn)
        rectbtn.layer.borderWidth = 2
        rectbtn.layer.borderColor = UIColor.white.cgColor
        circlebtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(view.snp.width).multipliedBy(0.25)
            $0.width.equalTo(view.snp.width).multipliedBy(0.25)
            $0.top.equalTo(alarmTable.snp.bottom).offset(40)
        }
        rectbtn.snp.makeConstraints{
            $0.centerX.equalTo(circlebtn )
            $0.centerY.equalTo(circlebtn)
            $0.height.equalTo(circlebtn.snp.height).multipliedBy(0.5)
            $0.width.equalTo(circlebtn.snp.width).multipliedBy(0.5)
        }
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(eraseeeee))
        rectbtn.addGestureRecognizer(tapgesture)
        rectbtn.isUserInteractionEnabled = true
        
     

    }
    private func RingAlarm(){
        DispatchQueue.global(qos: .background).async{
            Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.findtime), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
        
    }
    @objc func eraseeeee(){
        let animationview : LottieAnimationView = .init(name: "eyes")
        self.view.addSubview(animationview)
        animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFit
        animationview.frame = self.view.bounds
        animationview.play(completion: { [self] (completed)  in
            if showtable == true {
                showtable = false
                alarmTable.isHidden = true
            }else{
                showtable = true
                alarmTable.isHidden = false
            }
            animationview.isHidden = true
        })
        
    }
    @objc func findtime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE hh:mm"
        let showdate = formatter.string(from: date as Date)
        DispatchQueue.main.async {
            self.nowTime.text = "현재정보 :    \(showdate)"
        }
            
        
        let count = self.todolist.count
        for i in 0..<count{
            if(todolist[i][1] == showdate){
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "알람이 울립니다", message: self.todolist[i][0], preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(ok)
                    self.present(alert,animated: true)
                    UIView.animate(withDuration: 10.0, delay: 0) {
                        self.view.backgroundColor = .red
                        self.alarmTable.backgroundColor = .systemPink
                    }
                 
                }
            }
            else{
                DispatchQueue.main.async {
                    self.view.backgroundColor = .white
                    self.alarmTable.backgroundColor = .white
                }
            }
        }
        
    }
    @objc func addalarm(sender: UIButton!) {
        let animationView : LottieAnimationView = .init(name: "loadinganimation")
        self.alarmTable.addSubview(animationView)
        animationView.center = self.alarmTable.center
        animationView.contentMode = .scaleAspectFit
        animationView.frame = self.alarmTable.bounds
        animationView.play(completion: {
          (completed) in
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd EEE hh:mm"
            let date = dateformatter.string(from: self.datePicker.date)
            guard let whattodo = self.whatTodo.text else { return}
            self.todolist.append([whattodo,date])
            let datalist = UserDefaults.standard
            datalist.set(self.todolist,forKey: "datasave")
            animationView.isHidden = true
        })
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+2){
//
//
//        }
        

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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todolist.remove(at: indexPath.section)
            let datalist = UserDefaults.standard
            datalist.set(todolist,forKey: "datasave")
            
        }
    }
}
