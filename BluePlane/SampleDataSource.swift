//
//  SampleDataSource.swift
//  BluePlane
//
//  Created by 原田龍青 on 2019/12/25.
//  Copyright © 2019 原田龍青. All rights reserved.
//

import UIKit

struct Sample {
    let title: String
    let classPrefix: String
    
    func controller() -> UIViewController {
        let storyboard = UIStoryboard(name: classPrefix, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else {fatalError()}
        controller.title = title
        return controller
    }
}

struct SampleDataSource {
    let samples = [
        Sample(
            title: "勝野研",
            classPrefix: "KatunoLab"
        ),
        Sample(
            title: "徳田研",
            classPrefix: "TokudaLab"
        ),
        Sample(
            title: "築地研",
            classPrefix: "TukijiLab"
        ),
        Sample(
            title: "内川研",
            classPrefix: "UtikawaLab"
        ),
        Sample(
            title: "大塚研",
            classPrefix: "OtukaLab"
        ),
        Sample(
            title: "狩野研",
            classPrefix: "KanouLab"
        ),
        ]
}
