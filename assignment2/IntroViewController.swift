//
//  IntroViewController.swift
//  assignment2
//
//  Created by CloudLabs, Inc. on 2/13/16.
//  Copyright © 2016 Codepath. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    var yOffsets : [Float] = [-282, -260, -415, -408, -520, -500]
    var xOffsets : [Float] = [-70, 55, 16, 95, -140, -100]
    var scales : [CGFloat] = [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [CGFloat] = [-10, -10, 10, 10, 10, -10]
    let OFFSETMIN:CGFloat = 0
    let OFFSETMAX:CGFloat = 568
    
    @IBOutlet weak var tile1: UIImageView!
    @IBOutlet weak var tile2: UIImageView!
    @IBOutlet weak var tile3: UIImageView!
    @IBOutlet weak var tile4: UIImageView!
    @IBOutlet weak var tile5: UIImageView!
    @IBOutlet weak var tile6: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 1136)

        // Do any additional setup after loading the view.
        transformTiles(CGFloat(scrollView.contentOffset.y));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        transformTiles(CGFloat(scrollView.contentOffset.y));
    }
    
    func transformTiles(offset: CGFloat){
        //Could be more DRY
        transformTile(offset, index: 0, tile: tile1)
        transformTile(offset, index: 1, tile: tile2)
        transformTile(offset, index: 2, tile: tile3)
        transformTile(offset, index: 3, tile: tile4)
        transformTile(offset, index: 4, tile: tile5)
        transformTile(offset, index: 5, tile: tile6)
    }
    
    func transformTile(offset:CGFloat, index: Int, tile: UIImageView){
        var xOffset = CGFloat(xOffsets[index])
        var yOffset = CGFloat(yOffsets[index])

        
        var tx = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: xOffset, r2Max:0)
        var ty = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: yOffset, r2Max: 0)

        var scale = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: scales[index], r2Max: 1)
        var rotation = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: rotations[index], r2Max: 0)
        
        tile.transform = CGAffineTransformMakeTranslation(tx, ty)
        tile.transform = CGAffineTransformScale(tile.transform, scale, scale)
        tile.transform = CGAffineTransformRotate(tile.transform, CGFloat(Double(rotation) * M_PI / 180))
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
