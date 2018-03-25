//
//  LoginViewController.swift
//  Alpface
//
//  Created by swae on 2018/3/24.
//  Copyright © 2018年 alpface. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    fileprivate lazy var logoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont(name: "MedulaOne-Regular", size: 50.0)
        return label
    }()
    
    fileprivate lazy var usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    fileprivate lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    fileprivate lazy var usernameTf : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(textFieldsEditingChanged),for: .editingChanged)
        return tf
    }()
    
    fileprivate lazy var passwordTf : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(textFieldsEditingChanged),for: .editingChanged)
        return tf
    }()
    
    fileprivate var contentViewCenterYConstraint : NSLayoutConstraint?
    fileprivate var keyboardIsVisibleNotification : Notification?
    
    fileprivate lazy var loginButton : TransitionButton = {
        let button = TransitionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white.withAlphaComponent(0.03)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.55), for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.0))
        button.spinnerColor = UIColor.white
        button.cornerRadius = 25.0
        button.layer.cornerRadius = 3.0
        button.layer.masksToBounds = true
        button.addObserver(self, forKeyPath: "highlighted", options: .new, context: nil)
        button.addTarget(self, action: #selector(loginButtonClick(_:)), for: .touchUpInside)
        button.applyGradient(gradient: CAGradientLayer(), colours:[UIColor(hex:"00C3FF"), UIColor(hex:"FFFF1C")], locations:[0.0,1.0], stP:CGPoint(x:0.0,y:0.0), edP:CGPoint(x:1.0,y:0.0), gradientAnimation: CABasicAnimation())
        return button
    }()
    
    @objc func loginButtonClick(_ sender: TransitionButton) {
        
        usernameTf.isEnabled = false
        passwordTf.isEnabled = false
        registerButton.isEnabled = false
        
        sender.startAnimation()
        
        
    }
    
    fileprivate lazy var registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white.withAlphaComponent(0.03)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.55), for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.0))
        button.layer.cornerRadius = 3.0
        button.layer.masksToBounds = true
        button.addObserver(self, forKeyPath: "highlighted", options: .new, context: nil)
        return button
    }()
    
    fileprivate lazy var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate lazy var usernameContentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.22)
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    
    fileprivate lazy var passwordContentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.22)
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    
    fileprivate lazy var loginProblemButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        return button
    }()
    
    fileprivate lazy var pastelView : PastelView = {
        let pastelView = PastelView(frame: view.bounds)
        pastelView.translatesAutoresizingMaskIntoConstraints = false
        //MARK: -  Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        //MARK: -  Custom Duration
        pastelView.animationDuration = 3.0
        
        //MARK: -  Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        return pastelView
    }()
    
    fileprivate var loginButtonHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        createObserver()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.lightGray
        
        view.addSubview(pastelView)
        view.insertSubview(pastelView, at: 0)
        view.addSubview(contentView)
        contentView.addSubview(usernameContentView)
        contentView.addSubview(passwordContentView)
        contentView.addSubview(logoLabel)
        usernameContentView.addSubview(usernameLabel)
        usernameContentView.addSubview(usernameTf)
        passwordContentView.addSubview(passwordLabel)
        passwordContentView.addSubview(passwordTf)
        contentView.addSubview(loginButton)
        contentView.addSubview(loginProblemButton)
        contentView.addSubview(registerButton)
        setupConstraints()
        
        logoLabel.text = "Alpface"
        usernameLabel.text = "賬戶"
        passwordLabel.text = "密碼"
        loginButton.setTitle("登錄", for: .normal)
        loginProblemButton.setTitle("登錄遇到問題", for: .normal)
        registerButton.setTitle("需要一個新的賬戶", for: .normal)
        setupNavigationBar()
        updateLoginButtonLayout(animated: false)
    }
    
    fileprivate func setupConstraints() {
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentViewCenterYConstraint = contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        contentViewCenterYConstraint?.isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        logoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        usernameContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0).isActive = true
        usernameContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0).isActive = true
        
        passwordContentView.leadingAnchor.constraint(equalTo: usernameContentView.leadingAnchor).isActive = true
        passwordContentView.trailingAnchor.constraint(equalTo: usernameContentView.trailingAnchor).isActive = true
        
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[logoLabel]-(35.0)-[usernameContentView(==62.0)]-(15.0)-[passwordContentView(==62.0)]-(15.0)-[loginButton]-(15.0)-[loginProblemButton]-(15.0)-[registerButton(==50.0)]|", options: .alignAllCenterX, metrics: nil, views: ["logoLabel": logoLabel, "usernameContentView": usernameContentView, "passwordContentView": passwordContentView, "loginButton": loginButton, "loginProblemButton": loginProblemButton, "registerButton": registerButton]))
        
        loginButtonHeightConstraint = loginButton.heightAnchor.constraint(equalToConstant: 0.0)
        loginButtonHeightConstraint?.isActive = true
        loginButton.widthAnchor.constraint(equalTo: usernameContentView.widthAnchor, multiplier: 1.0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: usernameContentView.widthAnchor, multiplier: 1.0).isActive = true
        
        usernameLabel.setContentHuggingPriority(.required, for: .horizontal)
        usernameLabel.leadingAnchor.constraint(equalTo: usernameContentView.leadingAnchor, constant: 20.0).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: usernameContentView.centerYAnchor, constant: 0.0).isActive = true
        usernameTf.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 10.0).isActive = true
        usernameTf.trailingAnchor.constraint(equalTo: usernameContentView.trailingAnchor, constant: -20.0).isActive = true
        usernameTf.topAnchor.constraint(equalTo: usernameContentView.topAnchor).isActive = true
        usernameTf.bottomAnchor.constraint(equalTo: usernameContentView.bottomAnchor).isActive = true
        
        passwordLabel.setContentHuggingPriority(.required, for: .horizontal)
        passwordLabel.leadingAnchor.constraint(equalTo: passwordContentView.leadingAnchor, constant: 20.0).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: passwordContentView.centerYAnchor, constant: 0.0).isActive = true
        passwordTf.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: 10.0).isActive = true
        passwordTf.trailingAnchor.constraint(equalTo: usernameContentView.trailingAnchor, constant: -20.0).isActive = true
        passwordTf.topAnchor.constraint(equalTo: passwordContentView.topAnchor).isActive = true
        passwordTf.bottomAnchor.constraint(equalTo: passwordContentView.bottomAnchor).isActive = true
        
        pastelView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pastelView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pastelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pastelView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setupNavigationBar() {
        let backButton = UIButton()
        backButton.setTitle("取消", for: .normal)
        // 触摸按钮时发光
        backButton.showsTouchWhenHighlighted = true
        var frame = backButton.frame
        frame.size = CGSize(width: 44.0, height: 44.0)
        backButton.frame = frame
        backButton.addTarget(self, action: #selector(backBarButtonClick(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        // 设置导航栏标题属性：设置标题颜色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // 设置导航栏前景色：设置item指示色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // 设置导航栏半透明
        navigationController?.navigationBar.isTranslucent = true
        
        // 设置导航栏背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // 设置导航栏阴影图片
        navigationController?.navigationBar.shadowImage = UIImage()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pastelView.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    
    @objc private func backBarButtonClick(_ button: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let obj = object else { return }
        guard let keyPath = keyPath else { return }
        if keyPath == "highlighted" {
            let button = obj as! UIButton
            if button == loginButton {
                if button.isHighlighted {
                    button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                }
                else {
                    button.backgroundColor = UIColor.white.withAlphaComponent(0.03)
                }
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        loginButton.removeObserver(self, forKeyPath: "highlighted")
        registerButton.removeObserver(self, forKeyPath: "highlighted")
        releaseObservers()
    }

}

extension  LoginViewController {
    
    // 监听键盘
    fileprivate  func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    fileprivate func releaseObservers(){
        NotificationCenter.default.removeObserver(self)
    }
}
extension LoginViewController {
    
    @objc fileprivate func dismissKeyboard(){
        view.endEditing(true)
    }
    
    // 如果用户未输入账户和密码，隐藏登录按钮
    @objc fileprivate func textFieldsEditingChanged(sender: UITextField) {
        updateLoginButtonLayout()
    }
    
    fileprivate func updateLoginButtonLayout(animated : Bool = true) {
        loginButton.isHidden = (usernameTf.text?.isEmpty)! || (passwordTf.text?.isEmpty)!
        
        if loginButton.isHidden {
            loginButtonHeightConstraint?.constant = 0.0
        }
        else {
            loginButtonHeightConstraint?.constant = 50.0
        }
        let duration : Double = 0.35
        // 此处更新是为了获取contentView.frame真实的值
        UIView.animate(withDuration: (animated ? duration : 0.0)) {
            self.view.layoutIfNeeded()
        }
        if let notification = keyboardIsVisibleNotification {
            guard let userInfo = notification.userInfo else { return }
            // 获取键盘frame
            let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            // 键盘遮住文本了，就把contentView往上移
            let offset = contentView.frame.maxY - keyboardRect.origin.y
            contentViewCenterYConstraint?.constant -= offset
            UIView.animate(withDuration: (animated ? duration : 0.0)) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    // MARK: - Actions
    @objc private func keyboardWillShow(notification: Notification) {
        keyboardIsVisibleNotification = notification
        guard let userInfo = notification.userInfo else { return }
        // 获取键盘frame
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // 键盘弹出的时间
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        if contentView.frame.maxY > keyboardRect.origin.y {
            // 键盘遮住文本了，就把contentView往上移
            let offset = contentView.frame.maxY - keyboardRect.origin.y
            contentViewCenterYConstraint?.constant -= offset
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardIsVisibleNotification = nil
        guard let userInfo = notification.userInfo else { return }
        
        // 键盘弹出的时间
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        // 键盘遮住文本了，就把contentView往上移
        contentViewCenterYConstraint?.constant = 0
        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTf.resignFirstResponder()
        passwordTf.resignFirstResponder()
        return true
    }
    
}


