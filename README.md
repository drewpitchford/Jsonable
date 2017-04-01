## Jsonable is a Swift protocol that makes any conforming object able to be represented as a dictionary.

Tired of writing `zip()`,  `toDict()`, and other such methods for every one of your models? Then Jsonable is for you! Simply have your custom object conform to Jsonable, and with a simple `json()` call, it will be converted into a dictionary.

### Example Usage

```swift 
import Jsonable

class User: Jsonable {

    var name: String
    var address: String?

    init(name: String, address: String) {

        self.name = name
        self.address = address
    }
}

// Elsewhere in the code
let user = User(name: "Rey", address: "Jakku")
let params = user.json() 

// params now contains: ["name": "Rey", "address": "Jakku"]
```