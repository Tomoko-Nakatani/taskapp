//
//  Task.swift
//  taskapp
//
//  Created by PC-SYSKAI555 on 2022/09/05.
//

import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    // タイトル
    @objc dynamic var title = ""
    
    //カテゴリ
    @objc dynamic var category = ""

    // 内容
    @objc dynamic var contents = ""

    // 日時
    @objc dynamic var date = Date()

    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
   /* func realmMigration() {
        let migSchemaVersion: UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: migSchemaVersion,
                migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < migSchemaVersion) {}
            })
                    
            Realm.Configuration.defaultConfiguration = config
    }*/
}
