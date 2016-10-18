//
//  ImageStore.swift
//  LoginScreen
//
//  Created by Bogdan Koshyrets on 8/28/16.
//  Copyright © 2016 Bogdan Koshyrets. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.objectForKey(key) as? UIImage
    }
}
