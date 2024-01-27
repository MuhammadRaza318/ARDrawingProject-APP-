//
//  LessonTabelViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 26/12/2023.
//

import UIKit

class LessonTabelViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var LessonTableBackButton: UIButton!
    @IBOutlet weak var LessonTabel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        LessonTableBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        return cell
    }
    @objc func backButtonPressed() {
            // Back ButtonMethod
            self.navigationController?.popViewController(animated: true)
        }
}
