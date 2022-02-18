

import Foundation


extension String {
    
    func getImageURL() -> URL {
        let url = URL(string: "https://test.dev.cupist.de" + self)!
        return url
    }
    
}
