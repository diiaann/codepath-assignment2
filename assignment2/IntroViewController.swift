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
    
    let OFFSETMIN:CGFloat = 0
    let OFFSETMAX:CGFloat = 568
    var tiles: [Tile] = []
    
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

        initializeTileArray()
        transformTiles(CGFloat(scrollView.contentOffset.y));

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        transformTiles(CGFloat(scrollView.contentOffset.y));
    }
    
    func initializeTileArray(){
         tiles = [
            Tile(tileImage: tile1, xOffset:-70, yOffset:-282, scale: 1, rotation:-10),
            Tile(tileImage: tile2, xOffset: 55, yOffset:-260, scale: 1.65, rotation:-10),
            Tile(tileImage: tile3, xOffset: 16, yOffset:-415, scale: 1.7, rotation:10),
            Tile(tileImage: tile4, xOffset: 95, yOffset:-408, scale: 1.6, rotation:10),
            Tile(tileImage: tile5, xOffset:-140, yOffset:-520, scale: 1.65, rotation:10),
            Tile(tileImage: tile6, xOffset:-100, yOffset:-500, scale: 1.65, rotation:-10)
        ]
    }
    
    func transformTiles(offset: CGFloat){
        //Could be more DRY
        for tile in tiles {
            var tx = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: tile.xOffset, r2Max:0)
            var ty = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: tile.yOffset, r2Max: 0)
            
            var scale = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: tile.scale, r2Max: 1)
            var rotation = convertValue(offset, r1Min: OFFSETMIN , r1Max: OFFSETMAX, r2Min: tile.rotation, r2Max: 0)
            
            tile.tileImage.transform = CGAffineTransformMakeTranslation(tx, ty)
            tile.tileImage.transform = CGAffineTransformScale(tile.tileImage.transform, scale, scale)
            tile.tileImage.transform = CGAffineTransformRotate(tile.tileImage.transform, CGFloat(Double(rotation) * M_PI / 180))
            
        }
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
