//
//  MovieItemCollectionViewCell.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import SDWebImage

class MovieItemCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    
    var movieVO : MovieVO? {
        didSet {
            if let movieVO = movieVO {
                imageViewMoviePoster.sd_setImage(with: URL(string: "\(ApiConfig.BASE_IMG_URL)\(movieVO.posterPath ?? "")"), placeholderImage: UIImage(systemName: "square.and.arrow.down.fill"))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
