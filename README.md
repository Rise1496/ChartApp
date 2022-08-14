# ChartApp

- Приложение которое отображает график по точкам запрошенным с сервера.
- Добавлена возможность увеличивать график.
- Точки графика связаны сглаженной линией, а не ломаной.
- Добавлена поддержка сохранения графика в файл.
- Добавлены всевозможные обработки ошибок.
- Приложение написано на Swift 5 под архитектурный паттерн MVVM с использованием flow coordinator для навигации и SPM для внедрения зависимостей.
- Использовано ядро которое подтягивается в виде пакета https://github.com/Rise1496/Core
- Использованы следующие пакеты: RxSwift, Moya/RxSwift, SnapKit, Charts.
