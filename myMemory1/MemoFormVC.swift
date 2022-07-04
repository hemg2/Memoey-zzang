//
//  MemoFormVC.swift
//  myMemory1
//
//  Created by 1 on 2022/07/04.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save_(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
    let data = MemoData()
    data.title = self.subject
    data.contents = self.contents.text
    data.image = self.preview.image
    data.regdate = Date()
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    //카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick_(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        // 이미지 피커 컨트롤러를 닫는다.
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러 닫는다.
        picker.dismiss(animated: false)
    }
    override func viewDidLoad() {
        self.contents.delegate = self
    
    }
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //내비게이션 타이틀에 표시한다.
        self.navigationItem.title = self.subject
    }
}
