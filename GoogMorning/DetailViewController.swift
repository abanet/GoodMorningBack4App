//
//  DetailViewController.swift
//  GoogMorning
//
//  Created by Alberto Banet Masa on 27/2/15.
//  Copyright (c) 2015 Alberto Banet Masa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, protocoloParseFrases {

    @IBOutlet var viewFotoBuenosDias: UIImageView!
    @IBOutlet var frase: UILabel!
    @IBOutlet weak var btnCompartir: UIBarButtonItem!
    
    var fotoSegue: PFObject?
    private var parseFrases: ParseFrases!
    private var animacionMarcha: Bool!
    private var siguienteAnimacionTextoOn: Bool!
    private var autorFrase: String?
    
    
    override func viewDidLoad() {
        parseFrases = ParseFrases()
        parseFrases.delegate = self
        animacionMarcha = false
        siguienteAnimacionTextoOn = true
        self.frase.text = ""
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.btnCompartir.enabled = false
        self.frase.alpha = 0
        self.viewFotoBuenosDias.alpha = 0
        
        if let objetoSegue = fotoSegue {
           // frase.text = objetoSegue["fraseEng"] as String!
            let imagenPFFile = objetoSegue["foto"] as! PFFile
            imagenPFFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?)-> Void in
                if error == nil {
                  if let imageData = imageData {
                     let image = UIImage(data:imageData)
                      self.viewFotoBuenosDias.image = image
                      self.btnCompartir.enabled = true
                  } // if let imageData
                } // if error == nil
              } // getDataInBackgroundWithBlock
            } // let objetoSegue
      } // func
  
        


    // Compartir imagen y frase con las redes sociales
    @IBAction func compartirRedesSociales(sender: AnyObject) {
        
        let wsActivity = MMMWhatsAppActivity() // actividad de whatsapp
        
        let fraseYautor: String = self.frase.text! + " [\(autorFrase!)]"
        let objetosACompartir: [AnyObject!] = [fraseYautor, self.viewFotoBuenosDias.image, NSURL(string: NSLocalizedString("appURL", comment:"url de la app en el applestore"))]
        let activityController = UIActivityViewController(activityItems: objetosACompartir, applicationActivities: [wsActivity])
        activityController.excludedActivityTypes =  [
            UIActivityTypePostToWeibo,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList]
        self.presentViewController(activityController, animated: true, completion: nil)    }
    
    
    func animarTextoDurante(segundos: NSTimeInterval, delay: NSTimeInterval, alfaFinal: CGFloat){
        self.animacionMarcha = true
        UIView.animateWithDuration(segundos, delay: delay, options: [], animations: {
            self.frase.alpha = alfaFinal
            }, completion: {(completed: Bool) in
                if(completed){
                    self.animacionMarcha = false
                }
                return
        })
    }
    
    func animarImagenDurante(segundos: NSTimeInterval, delay: NSTimeInterval, alfaFinal: CGFloat){
        self.animacionMarcha = true
        UIView.animateWithDuration(segundos, delay: delay, options:[], animations: {
            self.viewFotoBuenosDias.alpha = alfaFinal
            }, completion: {(completed: Bool) in
                if(completed){
                    self.animacionMarcha = false
                }
                return
        })
    }
    
    // Se han cargado las frases. Elegimos una y la mostramos.
    func frasesCargadas() {
        //let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        //blur.frame = view.frame
        //view.addSubview(blur)
        (self.frase.text, autorFrase) = parseFrases.escogerUnaFraseAlAzar()
        
        animarTextoDurante(3.0, delay:0.0, alfaFinal: 1.0)
        animarImagenDurante(3.0, delay: 3.0, alfaFinal: 1.0)
        animarTextoDurante(3.0, delay: 3.0, alfaFinal: 0.0)
    }
    
   override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.animacionMarcha){
            if(!self.siguienteAnimacionTextoOn){
                animarTextoDurante(3.0, delay: 0.0 , alfaFinal: 0.0)
                animarImagenDurante(3.0, delay: 0.0, alfaFinal: 1.0)
            } else {
                animarTextoDurante(3.0, delay: 0.0 , alfaFinal: 1.0)
                animarImagenDurante(3.0, delay: 0.0, alfaFinal: 0.0)
            }
            siguienteAnimacionTextoOn = !siguienteAnimacionTextoOn
        }
    }
    
   
}