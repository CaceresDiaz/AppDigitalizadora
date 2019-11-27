//
//  ViewController.swift
//  EjemploDibujar
//
//  Created by Cáceres Díaz Jorge Carlos on 30/10/19.
//  Copyright © 2019 Cáceres Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageDraw: UIImageView!
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var sizeLine: CGFloat = 5.0
    var lastPoint = CGPoint.zero
    var movedTouch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movedTouch = false
        if let touch = touches.first {
            lastPoint = touch.location(in: imageDraw)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        movedTouch = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: imageDraw)
            drawLine(lastPoint, currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movedTouch {
            drawLine(lastPoint, lastPoint)
        }
    }
    
    
    func drawLine(_ startPoint: CGPoint, _ endPoint: CGPoint) {
        UIGraphicsBeginImageContext(imageDraw.bounds.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        imageDraw.image?.draw(in: imageDraw.bounds)
        
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.setLineCap(.round)
        context.setLineWidth(sizeLine)
        context.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        context.strokePath()
        
        imageDraw.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    @IBAction func cleanImage(_ sender: UIButton) {
        imageDraw.image = nil
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        if let imageToSave = imageDraw.image {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(self.image(_:didFinishSaveWithError:conextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSaveWithError error: Error?, conextInfo: UnsafeRawPointer) {
        
        if error == nil {
            
            let alert = UIAlertController(title: "Imagen guardada",
                                          message: "Se guardo tu imagen en el carrete",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            
            present(alert, animated: true, completion: nil)
        } else {
            
            let errorAlert = UIAlertController(title: "Ups!",
                                               message: "Error al guardar la imagen \(error!.localizedDescription)",
                preferredStyle: .alert)
            
            errorAlert.addAction(UIAlertAction(title: "Ok",
                                               style: .cancel,
                                               handler: nil))
            
            present(errorAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectColor(_ sender: UIButton) {
        sizeLine = 5
        switch (sender.tag)
        {
        case 0:
            //negro
            red = 0.0/255.0
            green = 0.0/255.0
            blue = 0.0/255.0
        case 1:
            //azul
            red = 0.0/255.0
            green = 0.0/255.0
            blue = 255.0/255.0
        case 2:
            //cafe
            red = 160.0/255.0
            green = 0.0/255.0
            blue = 85.0/255.0
        case 3:
            //verde
            red = 102.0/255.0
            green = 204.0/255.0
            blue = 0.0/255.0
        case 4:
            //naranja
            red = 255.0/255.0
            green = 102.0/255.0
            blue = 0.0/255.0
        case 5:
            //gris
            red = 105.0/255.0
            green = 105.0/255.0
            blue = 105.0/255.0
        case 6:
            //azul claro
            red = 51.0/255.0
            green = 204.0/255.0
            blue = 255.0/255.0
        case 7:
            //verde claro
            red = 102.0/255.0
            green = 255.0/255.0
            blue = 0.0/255.0
        case 8:
            //rojo
            red = 255.0/255.0
            green = 0.0/255.0
            blue = 0.0/255.0
        case 9:
            //amarillo
            red = 255.0/255.0
            green = 255.0/255.0
            blue = 0.0/255.0
        case 10:
            //blanco
            red = 255.0/255.0
            green = 255.0/255.0
            blue = 255.0/255.0
            sizeLine = 10
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

