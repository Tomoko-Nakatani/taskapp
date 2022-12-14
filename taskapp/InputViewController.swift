//
//  InputViewController.swift
//  taskapp
//
//  Created by PC-SYSKAI555 on 2022/09/04.
//

import UIKit
import RealmSwift
import UserNotifications
import SwiftUI

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    //課題追記
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //背景をタップしたらdismisskeyboardメソッドを呼びように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        titleTextField.placeholder = "タイトルを入力"
        //課題追記
        categoryTextField.text = task.category
        categoryTextField.placeholder = "カテゴリを入力"
        contentsTextView.text = task.contents
        datePicker.date = task.date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            //課題追記
            self.task.category = self.categoryTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.realm.add(self.task, update: .modified)
        }
     
        setNotification(task: task)
        
        super.viewWillDisappear(animated)
    }
    
    //タスクのローカル通知を登録する
    func setNotification(task: Task) {
    let content = UNMutableNotificationContent()
    //タイトル設定
    if task.title == "" {
        content.title = "(タイトルなし)"
    } else {
        content.title = task.title
    }
    
    
    //内容設定
    if task.contents == "" {
        content.body = "(内容なし)"
    } else {
        content.body = task.contents
    }
        content.sound = UNNotificationSound.default
    
    //ローカル通知が発動するtriggerを作成
    let calender = Calendar.current
    let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
    let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        
    //ローカル通知を登録
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error) in
        print(error ?? "ローカル通知登録 OK")
        
    }
    
    //未通知のローカル通知一覧をログ出力
    center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
        for request in requests {
            print("/---------------")
            print(request)
            print("---------------/")
            }
        }
        
    }
    
    @objc func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

