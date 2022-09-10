//
//  CacheManager.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 7.09.22.
//
import AlamofireImage

final class CacheManager {
    
    static let shared = CacheManager()
    
    private init() {}
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
