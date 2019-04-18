
import Foundation
import XCPlayground
import PlaygroundSupport
import UIKit

struct JobTitle: Codable {
    var id: String
    var name: String
    var typename: String

    init(dictionary: [String: AnyObject]) {
        self.init()
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.typename = dictionary["__typename"] as! String
    }

    init(id: String, name: String, typename: String) {
        self.id = id
        self.name = name
        self.typename = typename
    }

    static func getAllJobTitles(_ titles: [Dictionary<String, AnyObject>]) -> [JobTitle] {
        var jobTitles: [JobTitle]()
        for title in titles {
            let newJobTitle = JobTitle(dictionary: title)
            jobTitles.append(newJobTitle)
        }
        return jobTitles
    }
}

struct JobSubFamily: Codable {
    var id: String
    var name: String
    var jobTitle: JobTitle

    init(dictionary: [String: AnyObject]) {
        self.init()
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.jobTitle = JobTitle(dictionary: dictionary["jobTitle"])
    }

    init(id: String, name: String, jobTitle: JobTitle) {
        self.id = id
        self.name = name
        self.jobTitle = jobTitle
    }

    static func getAllJobSubfamily(_ subFamilies: [Dictionary<String, AnyObject>]) -> [JobSubFamily] {
        var jobSubFamilies: [JobSubFamily]()
        for subFamily in subFamilies {
            let newSubFamily = JobSubFamily(dictionary: subFamily)
            jobSubFamilies.append(newSubFamily)
        }
        return jobSubFamilies
    }
}

struct Jobfamily: Codable {
    var id: String
    var name: String
    var jobSubFamily: JobSubFamily

    init(dictionary: [String: AnyObject]) {
        self.init()
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.jobSubFamily = jobSubFamily(dictionary: dictionary["jobSubFamily"])
    }

    init(id: String, name: String, jobSubFamily: JobSubFamily) {
        self.id = id
        self.name = name
        self.jobSubFamily = jobSubFamily
    }

    static func getAllJobfamily(_ families: [Dictionary<String, AnyObject>]) -> [Jobfamily] {
        var jobFamilies: [Jobfamily]()
        for family in families {
            let newFamily = Jobfamily(dictionary: family)
            jobFamilies.append(newFamily)
        }
        return jobFamilies
    }
}

do {
    if let file = URL(string: "https://raw.githubusercontent.com/jogendra/zenefits-test/master/jobFamily.json") {
        let data = try Data(contentsOf: file)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        if let jobFamilies = json as? [Any] {
            print(jobFamilies)
        }
    }
}


PlaygroundPage.current.needsIndefiniteExecution = true
