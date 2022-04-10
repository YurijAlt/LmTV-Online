//
//  Channels.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 09.04.2022.
//

import RealmSwift
import Foundation

class FavoriteChannel: Object {
    @Persisted dynamic var name = ""
    @Persisted dynamic var url = ""
    @Persisted dynamic var image = ""
    @Persisted dynamic var title = ""
}

