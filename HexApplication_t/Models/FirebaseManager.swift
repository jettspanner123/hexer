import Foundation
import FirebaseFirestore

class FirebaseManager {
    let db = Firestore.firestore()

    func syncColors(_ colors: [CustomColor], completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        for color in colors where !color.isSynced {
            group.enter()
            db.collection("colors").document(color.id).setData([
                "id": color.id,
                "red": color.red,
                "green": color.green,
                "blue": color.blue,
                "hex": color.hex,
                "timestamp": color.timestamp,
                "isSynced": color.isSynced
            ]) { error in
                if error == nil {
                    // handle sync success if needed
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}
