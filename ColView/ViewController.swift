//
//  ViewController.swift
//  ColView
//
//  Created by Revo Tech on 6/29/16.
//  Copyright © 2016 Revo Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = DataSource()
    
    let identifier = "collCell"
    let headerViewIdentifier = "HeaderView"


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    
    // MARK:- prepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // retrieve selected cell & fruit
        
        if let indexPath = getIndexPathForSelectedCell() {
            
            let fruit = dataSource.fruitsInGroup(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.fruit = fruit
        }
    }
    */
    // MARK:- Should Perform Segue
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    // MARK:- Selected Cell IndexPath
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if collectionView.indexPathsForSelectedItems()!.count > 0 {
            indexPath = collectionView.indexPathsForSelectedItems()![0]
        }
        return indexPath
    }
    
    // MARK:- Highlight
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.magentaColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    /*
    // MARK:- Editing
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
       // toolBar.hidden = !editing
    }
    
    // MARK:- Add Cell
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        let index = dataSource.addAndGetIndexForNewItem()
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.insertItemsAtIndexPaths([indexPath])
    }
    
    
    @IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFruits:[Fruit] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                let sectionfruits = dataSource.fruitsInGroup(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
            dataSource.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
    */

}

// MARK:- UICollectionView DataSource

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.groups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier,forIndexPath:indexPath) as! FruitCell
        
        let fruits: [Fruit] = dataSource.fruitsInGroup(indexPath.section)
        let fruit = fruits[indexPath.row]
        
        let name = fruit.name!
        
        cell.img_View.image = UIImage(named: name.lowercaseString)
        cell.fruit_lbl.text = name.capitalizedString
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView: FruitCellHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier, forIndexPath: indexPath) as! FruitCellHeader
        
        headerView.HeaderLabel.text = dataSource.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
        let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
            
           }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
        let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.clearColor()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectioViewDelegateFlowLayout methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        // http://stackoverflow.com/questions/28872001/uicollectionview-cell-spacing-based-on-device-sceen-size
        
        let length = (UIScreen.mainScreen().bounds.width-15)/2
        return CGSizeMake(length,length);
    }
}




