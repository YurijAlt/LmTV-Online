# LmTV-Online
## Приложение для просмотра потового видео (Онлайн-ТВ) из интернета с сохранением избранных каналов в пямять смартфона с помощью Realm.

<img src="https://i.ibb.co/6Z3zSYh/IMG-5931.png" width="200">  <img src="https://i.ibb.co/MprzsGr/IMG-5932.png" width="200">  <img src="https://i.ibb.co/5hpvCVx/IMG-5933.png" width="200">


### Основной использованный стек:
##### Main used stack:

UIKit, UITableViewController, UISearchBar, AVKit, Realm, MVP, Singleton, Code Layout

### Краткое описание:
#### Приложение для просмотра Онлайн-ТВ.
Приложение для получения списка и просмотра Онлайн-ТВ каналов с серевера через API (JSON) и сохранением выбранных каналов в избранное (в память устройства).

- Проект полностью написан на UIKit.
- Проект загружает название канала, передачи, логотип канала из JSON, полученного с публичного API
- Использована архитектура MVP.
- Использованы UISearchBar
- Использованы UITableView с кастомными ячейками UITableViewCell.
- Реализована возможность просмотра только одного плейлиста (при нажатии на любой канал из списка в таблице), т.к. API не выдает ссылки URL на плейлисты в JSON (на авторских правах).
- Добавлена функция сохранения понравившегося канала нажатием на звездочку в ячейке, сохранение в память с помощью Realm.
- Дизайн из макета, предоставленного в Figma, добавлены AppIcon.

##### Short description:
##### An application for storing and removing tags from clothes, which has the ability to add descriptions to clothes, select clothes care icons, as well as photos from the iPhone camera. In addition, the application contains recommendations for the care of clothes.

- The project is entirely written in UIKit.
- The project is localized only in English.
- Used architecture MVC.
- Used UITabBarController, UINavigationController.
- Used UITableView, UICollectionView with custom cells UICollectionViewCell and UITableViewCell.
- Implemented the ability to upload custom photos from the iPhone camera.
- Added filter function by date / alphabet among CoreData records.
- Displays a description of a garment care symbol in the UIAlertController that disappears by timer.
- Designed, AppIcon, LaunchScreen added.
