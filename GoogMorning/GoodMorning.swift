//
//  GoodMorning.swift
//  GoogMorning
//
//  Created by Alberto Banet Masa on 27/2/15.
//  Copyright (c) 2015 Alberto Banet Masa. All rights reserved.
//

import UIKit

class GoodMorning {
    let imagen: string
    let dia: String
    let mes: String
    let anno: String
    let autorFrase: String
    let fraseEng: String
    let visible: Bool
    
    init(objeto:AnyObject){
        let buenosDias = objeto as PFObject
        let imageFile = PFFile(name: buenosDias["foto"], contentsAtPath: <#String!#>)
    }
    
}
