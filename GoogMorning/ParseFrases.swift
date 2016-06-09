//
//  ParseFrases.swift
//  GoogMorning
//
//  Created by Alberto Banet Masa on 20/3/15.
//  Copyright (c) 2015 Alberto Banet Masa. All rights reserved.
//


import UIKit

protocol protocoloParseFrases
{
    func frasesCargadas()
}

class ParseFrases {
    
    var arrayFrases: [PFObject] = []
    var numFrases: Int {
        get {
            return arrayFrases.count
        }
    }
    var delegate:protocoloParseFrases?
    
    init (){
        cargarFrases()
    }
    
    // Cargamos la tabla de frases.
    // De momento cargamos todas. Después habrá que parametrizar para cargar las de un día, o un año, etc
    func cargarFrases() {
        let query = PFQuery(className:"Frases");
        query.cachePolicy = .NetworkElseCache
        query.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]?, error:NSError?)-> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
              if let objects = objects {
                for object in objects {
                    //NSLog("%@", object.objectId)
                    self.arrayFrases.append(object)
                }
                self.delegate?.frasesCargadas()
              }
            } else {
                // Log details of the failure
               //print("Error: %@ %@", error, error.userInfo)
            }
            
        }
        
    }

    func escogerUnaFraseAlAzar() -> (String?, String?) {
        let numero = Int(arc4random_uniform(UInt32(numFrases)))
        assert(numero < numFrases, "Índice de frase fuera de rango")
        let objeto: PFObject = arrayFrases[numero]
        return (objeto["fraseEng"] as? String, objeto["autor"] as? String)
    }
    
    
}
