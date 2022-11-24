//
//  LoginViewController.swift
//  AlarmAPP
//
//  Created by SunHo Lee on 2022/11/24.
//

import Foundation
import SnapKit
import KakaoSDKUser
import UIKit
class LoginViewController : UIViewController {
    let button: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "kakaologin"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        view.addSubview(button)
        button.addTarget(self, action: #selector(clicklogin), for: .touchUpInside)
        button.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
    }
    @objc func clicklogin(){
        if(UserApi.isKakaoTalkLoginAvailable()){
            UserApi.shared.loginWithKakaoAccount{(oauthtoken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("success")
                    _ = oauthtoken
                    let accesstoken = oauthtoken?.accessToken
                    self.setUserinfo()
                    
                }
            }
        }
    }
    private func setUserinfo(){
        UserApi.shared.me(){(user,error) in
            if let error = error {
                print(error)
            }
            else{
                print("mesucess")
                _=user
                var mainvc = ViewController()
                if let url = user?.kakaoAccount?.profile?.profileImageUrl, let data = try? Data(contentsOf: url), let username = user?.kakaoAccount?.profile?.nickname {
                    mainvc.profilename.text = "\(username)님 환영합니다"
                    mainvc.profileimg.image = UIImage(data: data)
                }
                self.navigationController?.pushViewController(mainvc, animated: true)
                
            }
        }
    }
}
