import Foundation

struct PhotoDetailsResponse: Decodable {
    let photo: PhotoDetails
    let stat: String
    
    struct PhotoDetails: Decodable {
        let id: String
        let owner: Owner
        let title: Content
        let description: Content
        let dates: Dates
        let views: String
        let tags: Tags
        let urls: Urls
        
        struct Owner: Decodable {
            let nsid: String
            let username: String
            let realname: String?
            let location: String?
        }
        
        struct Content: Decodable {
            let _content: String
        }
        
        struct Dates: Decodable {
            let posted: String
            let taken: String
            let lastupdate: String
        }
        
        struct Tags: Decodable {
            let tag: [Tag]
            
            struct Tag: Decodable {
                let raw: String
                let _content: String
            }
        }
        
        struct Urls: Decodable {
            let url: [Url]
            
            struct Url: Decodable {
                let type: String
                let _content: String
            }
        }
    }
}
