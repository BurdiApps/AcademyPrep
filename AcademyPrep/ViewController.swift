//
//  ViewController.swift
//  AcademyPrep
//
//  Created by James Burdick on 10/3/26.
//

import UIKit

// MARK: - Model

enum Weekday: Int, CaseIterable {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

    /// Single-letter header used in the calendar and schedule, Sunday-first.
    var short: String { ["S", "M", "T", "W", "T", "F", "S"][rawValue - 1] }
}

struct Exercise {
    let name: String
    let prescription: String
    let category: String
}

struct Workout {
    let id: String
    let title: String
    let focus: String
    let duration: String
    /// Days of the week this session is scheduled on.
    let weekdays: [Weekday]
    let exercises: [Exercise]
}

struct TrainingWeek {
    let number: Int
    let title: String
    let workouts: [Workout]
}

struct TrainingMonth {
    let number: Int
    let title: String
    let weeks: [TrainingWeek]
}

// MARK: - Store

final class WorkoutStore {
    static let shared = WorkoutStore()

    // Everyday bookends, straight from the booklet.
    private static let warmUp = Exercise(
        name: "Warm-Up / Stretching",
        prescription: "Light jog / brisk walk 5–10 min, then stretch",
        category: "Everyday")
    private static let coolDown = Exercise(
        name: "Cool-Down / Stretching",
        prescription: "Light jog / brisk walk 5–10 min, then stretch",
        category: "Everyday")

    private static let runDays: [Weekday] = [.monday, .wednesday, .friday]
    private static let calDays: [Weekday] = [.sunday, .tuesday, .thursday, .saturday]

    private static func runWorkout(id: String, distance: String) -> Workout {
        Workout(
            id: id,
            title: "Run Day",
            focus: "Run \(distance)",
            duration: "~30–40 min",
            weekdays: runDays,
            exercises: [
                warmUp,
                Exercise(name: "Run \(distance)",
                         prescription: "10–12 min/mile pace on a shock-absorbing surface (track). No treadmill.",
                         category: "Running"),
                coolDown
            ])
    }

    private static func calWorkout(id: String, _ items: [Exercise]) -> Workout {
        Workout(
            id: id,
            title: "Calisthenics Day",
            focus: "Strength & core",
            duration: "~20–25 min",
            weekdays: calDays,
            exercises: [warmUp] + items + [coolDown])
    }

    private static func cal(_ pairs: [(String, String)]) -> [Exercise] {
        pairs.map { Exercise(name: $0.0, prescription: $0.1, category: "Calisthenics") }
    }

    // Program data transcribed from the CHP APP Preparation Booklet.
    let months: [TrainingMonth] = [
        TrainingMonth(number: 1, title: "Foundation", weeks: [
            TrainingWeek(number: 1, title: "Build your base", workouts: [
                runWorkout(id: "m1w1-run", distance: "1/2 Mile"),
                calWorkout(id: "m1w1-cal", cal([
                    ("Push-Ups", "10–20 reps / 2 sets"),
                    ("Sit-Ups", "20–25 reps / 2 sets"),
                    ("Pull-Ups", "1–10 reps / 2 sets"),
                    ("Leg-Lifts", "10–20 reps / 2 sets"),
                    ("Nose-in-the-Rings", "10–20 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 2, title: "Add volume", workouts: [
                runWorkout(id: "m1w2-run", distance: "1/2 Mile"),
                calWorkout(id: "m1w2-cal", cal([
                    ("Push-Ups", "10–20 reps / 2 sets"),
                    ("Sit-Ups", "20–25 reps / 2 sets"),
                    ("Squats", "10–20 reps / 2 sets"),
                    ("Leg-Lifts", "10–20 reps / 2 sets"),
                    ("Nose-in-the-Rings", "10–20 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 3, title: "Raise the distance", workouts: [
                runWorkout(id: "m1w3-run", distance: "1 Mile"),
                calWorkout(id: "m1w3-cal", cal([
                    ("Push-Ups", "15–20 reps / 2 sets"),
                    ("Sit-Ups", "20–25 reps / 2 sets"),
                    ("Pull-Ups", "3–10 reps / 2 sets"),
                    ("Leg-Lifts", "15–25 reps / 2 sets"),
                    ("Nose-in-the-Rings", "10–20 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 4, title: "Consolidate", workouts: [
                runWorkout(id: "m1w4-run", distance: "1 Mile"),
                calWorkout(id: "m1w4-cal", cal([
                    ("Push-Ups", "15–20 reps / 2 sets"),
                    ("Sit-Ups", "25–30 reps / 2 sets"),
                    ("Squats", "15–25 reps / 2 sets"),
                    ("Leg-Lifts", "15–25 reps / 2 sets"),
                    ("Nose-in-the-Rings", "10–20 reps / 2 sets")
                ]))
            ])
        ]),
        TrainingMonth(number: 2, title: "Build", weeks: [
            TrainingWeek(number: 5, title: "Stretch the run", workouts: [
                runWorkout(id: "m2w5-run", distance: "1-1/2 Miles"),
                calWorkout(id: "m2w5-cal", cal([
                    ("Push-Ups", "15–25 reps / 2 sets"),
                    ("Sit-Ups", "25–30 reps / 2 sets"),
                    ("Pull-Ups", "3–10 reps / 2 sets"),
                    ("Leg-Lifts", "15–25 reps / 2 sets"),
                    ("Nose-in-the-Rings", "15–25 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 6, title: "Push the pace", workouts: [
                runWorkout(id: "m2w6-run", distance: "2 Miles"),
                calWorkout(id: "m2w6-cal", cal([
                    ("Push-Ups", "20–30 reps / 2 sets"),
                    ("Sit-Ups", "30–40 reps / 2 sets"),
                    ("Pull-Ups", "5–10 reps / 2 sets"),
                    ("Leg-Lifts", "20–30 reps / 2 sets"),
                    ("Nose-in-the-Rings", "15–25 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 7, title: "Hold the line", workouts: [
                runWorkout(id: "m2w7-run", distance: "1-1/2 Miles"),
                calWorkout(id: "m2w7-cal", cal([
                    ("Push-Ups", "15–25 reps / 2 sets"),
                    ("Sit-Ups", "25–30 reps / 2 sets"),
                    ("Squats", "20–25 reps / 2 sets"),
                    ("Leg-Lifts", "15–25 reps / 2 sets"),
                    ("Nose-in-the-Rings", "15–25 reps / 2 sets")
                ]))
            ]),
            TrainingWeek(number: 8, title: "Peak the month", workouts: [
                runWorkout(id: "m2w8-run", distance: "2 Miles"),
                calWorkout(id: "m2w8-cal", cal([
                    ("Push-Ups", "25–35 reps / 2 sets"),
                    ("Sit-Ups", "35–45 reps / 2 sets"),
                    ("Squats", "35–45 reps / 2 sets"),
                    ("Leg-Lifts", "25–35 reps / 2 sets"),
                    ("Nose-in-the-Rings", "15–25 reps / 2 sets")
                ]))
            ])
        ])
    ]

    /// All weeks in program order, used to map calendar dates onto the schedule.
    var allWeeks: [TrainingWeek] { months.flatMap { $0.weeks } }
    var totalScheduledDays: Int { allWeeks.count * 7 }

    // MARK: Persistence keys

    private let completedKey = "completedWorkoutDates"
    private let customKey = "customWorkoutNames"
    private let startDateKey = "programStartDate"

    private let isoFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    func key(for date: Date) -> String { isoFormatter.string(from: Calendar.current.startOfDay(for: date)) }

    // MARK: Program start date

    /// The real-world date that maps to Week 1, Day 1 (a Sunday).
    var programStartDate: Date {
        get {
            let stored = UserDefaults.standard.double(forKey: startDateKey)
            if stored > 0 { return Date(timeIntervalSince1970: stored) }
            return WorkoutStore.sundayStartingWeek(of: Date())
        }
        set {
            let sunday = WorkoutStore.sundayStartingWeek(of: newValue)
            UserDefaults.standard.set(sunday.timeIntervalSince1970, forKey: startDateKey)
            NotificationCenter.default.post(name: .workoutStoreDidChange, object: nil)
        }
    }

    static func sundayStartingWeek(of date: Date) -> Date {
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: date) // 1 = Sunday
        let start = cal.startOfDay(for: date)
        return cal.date(byAdding: .day, value: -(weekday - 1), to: start) ?? start
    }

    /// The scheduled week + workout for a given calendar date, if it falls inside the program.
    func schedule(on date: Date) -> (month: TrainingMonth, week: TrainingWeek, workout: Workout)? {
        let cal = Calendar.current
        let start = cal.startOfDay(for: programStartDate)
        let day = cal.startOfDay(for: date)
        guard let offset = cal.dateComponents([.day], from: start, to: day).day, offset >= 0 else { return nil }
        let weekIndex = offset / 7
        guard weekIndex < allWeeks.count else { return nil }
        let week = allWeeks[weekIndex]
        let weekday = Weekday(rawValue: cal.component(.weekday, from: date))
        guard let workout = week.workouts.first(where: { weekday.map($0.weekdays.contains) ?? false }) else { return nil }
        let month = months.first { $0.weeks.contains { $0.number == week.number } } ?? months[0]
        return (month, week, workout)
    }

    func isScheduled(on date: Date) -> Bool { schedule(on: date) != nil }

    // MARK: Completion (keyed by date)

    var completedDateKeys: Set<String> {
        Set(UserDefaults.standard.stringArray(forKey: completedKey) ?? [])
    }

    var completedCount: Int { completedDateKeys.count }

    func isCompleted(on date: Date) -> Bool { completedDateKeys.contains(key(for: date)) }

    func setCompleted(_ completed: Bool, on date: Date) {
        var keys = completedDateKeys
        let k = key(for: date)
        if completed { keys.insert(k) } else { keys.remove(k) }
        UserDefaults.standard.set(Array(keys), forKey: completedKey)
        NotificationCenter.default.post(name: .workoutStoreDidChange, object: nil)
    }

    func resetCompletion() {
        UserDefaults.standard.removeObject(forKey: completedKey)
        NotificationCenter.default.post(name: .workoutStoreDidChange, object: nil)
    }

    // MARK: Custom workouts

    func addCustomWorkout(named name: String) {
        var names = UserDefaults.standard.stringArray(forKey: customKey) ?? []
        names.append(name)
        UserDefaults.standard.set(names, forKey: customKey)
        NotificationCenter.default.post(name: .workoutStoreDidChange, object: nil)
    }

    var customWorkoutNames: [String] {
        UserDefaults.standard.stringArray(forKey: customKey) ?? []
    }

    // MARK: Fitness log

    func logValue(month: Int, field: String) -> String {
        UserDefaults.standard.string(forKey: "log.m\(month).\(field)") ?? ""
    }

    func setLogValue(_ value: String, month: Int, field: String) {
        UserDefaults.standard.set(value, forKey: "log.m\(month).\(field)")
    }
}

extension Notification.Name {
    static let workoutStoreDidChange = Notification.Name("workoutStoreDidChange")
}

// MARK: - Theme

enum AppTheme {
    static let navy = UIColor(red: 0.03, green: 0.10, blue: 0.24, alpha: 1)
    static let blue = UIColor(red: 0.10, green: 0.39, blue: 0.78, alpha: 1)
    static let green = UIColor(red: 0.10, green: 0.62, blue: 0.42, alpha: 1)
    static let background = UIColor.systemGroupedBackground
}

// MARK: - Drawer container (hamburger + side menu)

final class DrawerContainerViewController: UIViewController {

    enum MenuItem: Int, CaseIterable {
        case calendar, home, program, custom, progress, fitnessLog, settings

        var title: String {
            switch self {
            case .calendar: return "Calendar"
            case .home: return "Home"
            case .program: return "Program"
            case .custom: return "Custom"
            case .progress: return "Progress"
            case .fitnessLog: return "Fitness Log"
            case .settings: return "Settings"
            }
        }

        var icon: String {
            switch self {
            case .calendar: return "calendar"
            case .home: return "house"
            case .program: return "list.bullet.rectangle"
            case .custom: return "plus.circle"
            case .progress: return "chart.bar"
            case .fitnessLog: return "square.and.pencil"
            case .settings: return "gearshape"
            }
        }

        func makeRoot() -> UIViewController {
            switch self {
            case .calendar: return CalendarViewController()
            case .home: return HomeViewController()
            case .program: return ProgramViewController()
            case .custom: return CustomWorkoutsViewController()
            case .progress: return ProgressViewController()
            case .fitnessLog: return FitnessLogViewController()
            case .settings: return SettingsViewController()
            }
        }
    }

    /// Items surfaced in the bottom quick-access bar (in order).
    static let bottomBarItems: [MenuItem] = [.home, .calendar, .program, .progress, .fitnessLog]

    private let contentNav = UINavigationController()
    private let dimmingView = UIView()
    private let menuPanel = UIView()
    private let menuStack = UIStackView()
    private let bottomBar = UIView()
    private let bottomBarStack = UIStackView()
    private let menuWidth: CGFloat = 288
    private var menuLeading: NSLayoutConstraint!
    private(set) var isMenuOpen = false
    private var selected: MenuItem = .home

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.background
        setupContent()
        setupBottomBar()
        pinContentToBottomBar()
        setupDimming()
        setupMenu()
        select(.home)
    }

    private func setupContent() {
        addChild(contentNav)
        view.addSubview(contentNav.view)
        contentNav.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentNav.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentNav.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentNav.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentNav.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentNav.didMove(toParent: self)
        contentNav.navigationBar.prefersLargeTitles = true
    }

    /// Lifts the content so it rests on top of the bottom bar instead of behind it.
    private func pinContentToBottomBar() {
        contentNav.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }

    private func setupBottomBar() {
        bottomBar.backgroundColor = .secondarySystemGroupedBackground
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        let hairline = UIView()
        hairline.backgroundColor = .separator
        hairline.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(hairline)

        bottomBarStack.axis = .horizontal
        bottomBarStack.distribution = .fillEqually
        bottomBarStack.alignment = .fill
        bottomBarStack.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(bottomBarStack)

        for item in Self.bottomBarItems {
            bottomBarStack.addArrangedSubview(makeBottomBarButton(item))
        }

        view.addSubview(bottomBar)
        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            hairline.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            hairline.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            hairline.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            hairline.heightAnchor.constraint(equalToConstant: 0.5),

            bottomBarStack.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8),
            bottomBarStack.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            bottomBarStack.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            bottomBarStack.bottomAnchor.constraint(equalTo: bottomBar.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            bottomBarStack.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func makeBottomBarButton(_ item: MenuItem) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: item.icon)
        config.title = item.title
        config.imagePlacement = .top
        config.imagePadding = 3
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 10, weight: .medium)
            return outgoing
        }
        let button = UIButton(configuration: config)
        button.tag = item.rawValue
        button.accessibilityIdentifier = "tab.\(item.title.lowercased())"
        button.addAction(UIAction { [weak self] _ in self?.select(item) }, for: .touchUpInside)
        return button
    }

    private func setupDimming() {
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.alpha = 0
        dimmingView.isHidden = true
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMenu)))
    }

    private func setupMenu() {
        menuPanel.backgroundColor = AppTheme.navy
        menuPanel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuPanel)
        menuLeading = menuPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -menuWidth)
        NSLayoutConstraint.activate([
            menuLeading,
            menuPanel.topAnchor.constraint(equalTo: view.topAnchor),
            menuPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuPanel.widthAnchor.constraint(equalToConstant: menuWidth)
        ])

        let header = UIStackView()
        header.axis = .vertical
        header.spacing = 4
        let brand = UILabel()
        brand.text = "CHP TRACKER"
        brand.font = .systemFont(ofSize: 22, weight: .heavy)
        brand.textColor = .white
        let subtitle = UILabel()
        subtitle.text = "APP Preparation Program"
        subtitle.font = .preferredFont(forTextStyle: .footnote)
        subtitle.textColor = UIColor.white.withAlphaComponent(0.7)
        header.addArrangedSubview(brand)
        header.addArrangedSubview(subtitle)

        menuStack.axis = .vertical
        menuStack.spacing = 4
        menuStack.translatesAutoresizingMaskIntoConstraints = false

        let container = UIStackView(arrangedSubviews: [header, menuStack])
        container.axis = .vertical
        container.spacing = 26
        container.translatesAutoresizingMaskIntoConstraints = false
        menuPanel.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: menuPanel.safeAreaLayoutGuide.topAnchor, constant: 24),
            container.leadingAnchor.constraint(equalTo: menuPanel.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: menuPanel.trailingAnchor, constant: -16)
        ])

        for item in MenuItem.allCases {
            menuStack.addArrangedSubview(makeMenuRow(item))
        }
    }

    private func makeMenuRow(_ item: MenuItem) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = item.title
        config.image = UIImage(systemName: item.icon)
        config.imagePadding = 14
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 14)
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .leading
        button.tag = item.rawValue
        button.layer.cornerRadius = 12
        button.accessibilityIdentifier = "menu.\(item.title.lowercased())"
        button.addAction(UIAction { [weak self] _ in self?.select(item) }, for: .touchUpInside)
        return button
    }

    private func highlightSelection() {
        for view in menuStack.arrangedSubviews {
            guard let button = view as? UIButton else { continue }
            button.backgroundColor = button.tag == selected.rawValue
                ? UIColor.white.withAlphaComponent(0.16) : .clear
        }
        for view in bottomBarStack.arrangedSubviews {
            guard let button = view as? UIButton else { continue }
            button.configuration?.baseForegroundColor = button.tag == selected.rawValue
                ? AppTheme.blue : .secondaryLabel
        }
    }

    func select(_ item: MenuItem) {
        if item != selected || contentNav.viewControllers.isEmpty {
            selected = item
            contentNav.setViewControllers([item.makeRoot()], animated: false)
        }
        highlightSelection()
        closeMenu()
    }

    @objc func toggleMenu() { isMenuOpen ? closeMenu() : openMenu() }

    func openMenu() {
        guard !isMenuOpen else { return }
        isMenuOpen = true
        dimmingView.isHidden = false
        view.bringSubviewToFront(dimmingView)
        view.bringSubviewToFront(menuPanel)
        menuLeading.constant = 0
        UIView.animate(withDuration: 0.28, delay: 0, options: .curveEaseOut) {
            self.dimmingView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    @objc func closeMenu() {
        guard isMenuOpen else { return }
        isMenuOpen = false
        menuLeading.constant = -menuWidth
        UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseIn) {
            self.dimmingView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dimmingView.isHidden = true
        }
    }
}

// MARK: - Base

class BaseViewController: UIViewController {
    let store = WorkoutStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.background
        addMenuButton()
        NotificationCenter.default.addObserver(self, selector: #selector(storeDidChange), name: .workoutStoreDidChange, object: nil)
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    @objc func storeDidChange() { }

    /// Adds the hamburger button that opens the side menu. Only shown on section roots.
    func addMenuButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                   style: .plain, target: self, action: #selector(openDrawer))
        item.accessibilityIdentifier = "nav.menu"
        navigationItem.leftBarButtonItem = item
    }

    @objc private func openDrawer() {
        (navigationController?.parent as? DrawerContainerViewController)?.openMenu()
    }

    func makeScrollView() -> (UIScrollView, UIStackView) {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 28, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        scroll.addSubview(stack)
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])
        return (scroll, stack)
    }

    func label(_ text: String, font: UIFont = .preferredFont(forTextStyle: .body), color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        return label
    }

    func card() -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 14
        return card
    }

    /// Wraps content in a padded card and returns the card.
    func card(wrapping content: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 18)) -> UIView {
        let card = card()
        card.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: card.topAnchor, constant: insets.top),
            content.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: insets.left),
            content.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -insets.right),
            content.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -insets.bottom)
        ])
        return card
    }

    func button(title: String, action: Selector) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .medium
        config.baseBackgroundColor = AppTheme.navy
        let button = UIButton(configuration: config)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

// MARK: - Home

final class HomeViewController: BaseViewController {
    private var stack: UIStackView!

    private let longDate: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEEE, MMM d"
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CHP Tracker"
        (_, stack) = makeScrollView()
        rebuild()
    }

    override func storeDidChange() { rebuild() }

    private func rebuild() {
        guard stack != nil else { return }
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stack.addArrangedSubview(label("Train with purpose.", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        stack.addArrangedSubview(label("Your next step toward being prepared for more.", color: .secondaryLabel))

        // Progress card
        let progressStack = UIStackView()
        progressStack.axis = .vertical
        progressStack.spacing = 10
        let count = store.completedCount
        let total = store.totalScheduledDays
        progressStack.addArrangedSubview(label("PROGRAM PROGRESS", font: .preferredFont(forTextStyle: .caption1), color: AppTheme.blue))
        progressStack.addArrangedSubview(label("\(count) of \(total) sessions complete", font: .preferredFont(forTextStyle: .headline)))
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = AppTheme.green
        progress.progress = total == 0 ? 0 : Float(count) / Float(total)
        progressStack.addArrangedSubview(progress)
        stack.addArrangedSubview(card(wrapping: progressStack))

        // Today's session card
        let today = Date()
        let todayStack = UIStackView()
        todayStack.axis = .vertical
        todayStack.spacing = 8
        todayStack.addArrangedSubview(label("TODAY · \(longDate.string(from: today))", font: .preferredFont(forTextStyle: .caption1), color: AppTheme.blue))

        if let plan = store.schedule(on: today) {
            let done = store.isCompleted(on: today)
            todayStack.addArrangedSubview(label("\(done ? "✓ " : "")Week \(plan.week.number) · \(plan.workout.title)",
                                                font: .preferredFont(forTextStyle: .headline),
                                                color: done ? AppTheme.green : .label))
            todayStack.addArrangedSubview(label("\(plan.workout.focus) • \(plan.workout.duration)", color: .secondaryLabel))
            let open = button(title: done ? "Review today's session" : "Start today's session", action: #selector(openToday))
            open.accessibilityIdentifier = "home.today"
            todayStack.addArrangedSubview(open)
        } else {
            todayStack.addArrangedSubview(label("No CHP session scheduled today", font: .preferredFont(forTextStyle: .headline)))
            todayStack.addArrangedSubview(label("Open the Calendar to see your program days, or set your start date in Settings.", color: .secondaryLabel))
            let openCal = button(title: "Open Calendar", action: #selector(openCalendar))
            todayStack.addArrangedSubview(openCal)
        }
        stack.addArrangedSubview(card(wrapping: todayStack))
    }

    @objc private func openToday() {
        guard let plan = store.schedule(on: Date()) else { return }
        navigationController?.pushViewController(WorkoutDetailViewController(workout: plan.workout, date: Date()), animated: true)
    }

    @objc private func openCalendar() {
        (navigationController?.parent as? DrawerContainerViewController)?.select(.calendar)
    }
}

// MARK: - Calendar

final class CalendarViewController: BaseViewController {

    private struct Day {
        let date: Date?          // nil for leading/trailing blanks
        let number: Int
    }

    private let monthLabel = UILabel()
    private var collectionView: UICollectionView!
    private var collectionHeight: NSLayoutConstraint!
    private let detailContainer = UIStackView()

    private let cal = Calendar.current
    private var displayedMonth = Date()      // any date within the shown month
    private var selectedDate: Date?
    private var days: [Day] = []

    private let monthTitle: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "MMMM yyyy"; return f
    }()
    private let longDate: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE, MMM d"; return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(jumpToToday))
        displayedMonth = firstOfMonth(for: Date())
        selectedDate = cal.startOfDay(for: Date())
        buildLayout()
        reloadMonth()
    }

    override func storeDidChange() {
        collectionView.reloadData()
        updateDetail()
    }

    // MARK: Layout

    private func buildLayout() {
        let (_, stack) = makeScrollView()

        // Month header with prev / next
        let prev = UIButton(type: .system)
        prev.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        prev.tintColor = AppTheme.navy
        prev.addAction(UIAction { [weak self] _ in self?.changeMonth(by: -1) }, for: .touchUpInside)
        let next = UIButton(type: .system)
        next.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        next.tintColor = AppTheme.navy
        next.addAction(UIAction { [weak self] _ in self?.changeMonth(by: 1) }, for: .touchUpInside)
        monthLabel.font = .preferredFont(forTextStyle: .title2)
        monthLabel.textColor = AppTheme.navy
        monthLabel.textAlignment = .center
        let header = UIStackView(arrangedSubviews: [prev, monthLabel, next])
        header.axis = .horizontal
        header.alignment = .center
        header.distribution = .fill
        monthLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.addArrangedSubview(header)

        // Weekday header row (Sunday-first)
        let weekdayRow = UIStackView()
        weekdayRow.axis = .horizontal
        weekdayRow.distribution = .fillEqually
        for wd in Weekday.allCases {
            let l = UILabel()
            l.text = wd.short
            l.textAlignment = .center
            l.font = .preferredFont(forTextStyle: .caption1)
            l.textColor = .secondaryLabel
            weekdayRow.addArrangedSubview(l)
        }
        stack.addArrangedSubview(weekdayRow)

        // Grid
        let flow = UICollectionViewFlowLayout()
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 6
        flow.sectionInset = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.reuseID)
        stack.addArrangedSubview(collectionView)
        collectionHeight = collectionView.heightAnchor.constraint(equalToConstant: 300)
        collectionHeight.isActive = true

        // Legend
        let legend = label("Blue dot = scheduled  •  Green = completed  •  Ring = today", font: .preferredFont(forTextStyle: .caption1), color: .secondaryLabel)
        legend.textAlignment = .center
        stack.addArrangedSubview(legend)

        // Selected-day detail
        detailContainer.axis = .vertical
        detailContainer.spacing = 10
        stack.addArrangedSubview(card(wrapping: detailContainer))
    }

    // MARK: Data

    private func firstOfMonth(for date: Date) -> Date {
        cal.date(from: cal.dateComponents([.year, .month], from: date)) ?? date
    }

    private func reloadMonth() {
        monthLabel.text = monthTitle.string(from: displayedMonth)
        let first = firstOfMonth(for: displayedMonth)
        let daysInMonth = cal.range(of: .day, in: .month, for: first)?.count ?? 30
        let leadingBlanks = cal.component(.weekday, from: first) - 1  // Sunday = 0 offset

        var result: [Day] = []
        for _ in 0..<leadingBlanks { result.append(Day(date: nil, number: 0)) }
        for d in 1...daysInMonth {
            let date = cal.date(byAdding: .day, value: d - 1, to: first)
            result.append(Day(date: date, number: d))
        }
        while result.count % 7 != 0 { result.append(Day(date: nil, number: 0)) }
        days = result

        let rows = days.count / 7
        collectionHeight.constant = CGFloat(rows) * 44 + CGFloat(rows - 1) * 6
        collectionView.reloadData()
        updateDetail()
    }

    private func changeMonth(by delta: Int) {
        if let d = cal.date(byAdding: .month, value: delta, to: displayedMonth) {
            displayedMonth = firstOfMonth(for: d)
            reloadMonth()
        }
    }

    @objc private func jumpToToday() {
        displayedMonth = firstOfMonth(for: Date())
        selectedDate = cal.startOfDay(for: Date())
        reloadMonth()
    }

    private func updateDetail() {
        detailContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        guard let date = selectedDate else {
            detailContainer.addArrangedSubview(label("Select a day to see its session.", color: .secondaryLabel))
            return
        }
        detailContainer.addArrangedSubview(label(longDate.string(from: date), font: .preferredFont(forTextStyle: .headline), color: AppTheme.navy))

        guard let plan = store.schedule(on: date) else {
            detailContainer.addArrangedSubview(label("No CHP session scheduled. This day is outside your program window.", color: .secondaryLabel))
            return
        }
        let done = store.isCompleted(on: date)
        detailContainer.addArrangedSubview(label("Week \(plan.week.number) · \(plan.week.title)", color: AppTheme.blue))
        detailContainer.addArrangedSubview(label("\(done ? "✓ " : "")\(plan.workout.title) — \(plan.workout.focus)",
                                                 font: .preferredFont(forTextStyle: .subheadline),
                                                 color: done ? AppTheme.green : .label))
        let open = button(title: done ? "Review session" : "Open session", action: #selector(openSelected))
        open.accessibilityIdentifier = "calendar.openSession"
        detailContainer.addArrangedSubview(open)
    }

    @objc private func openSelected() {
        guard let date = selectedDate, let plan = store.schedule(on: date) else { return }
        navigationController?.pushViewController(WorkoutDetailViewController(workout: plan.workout, date: date), animated: true)
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { days.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.reuseID, for: indexPath) as! CalendarDayCell
        let day = days[indexPath.item]
        if let date = day.date {
            cell.configure(
                number: day.number,
                isToday: cal.isDateInToday(date),
                isSelected: selectedDate.map { cal.isDate($0, inSameDayAs: date) } ?? false,
                isCompleted: store.isCompleted(on: date),
                isScheduled: store.isScheduled(on: date))
        } else {
            cell.configureBlank()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(collectionView.bounds.width / 7)
        return CGSize(width: width, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let date = days[indexPath.item].date else { return }
        selectedDate = cal.startOfDay(for: date)
        collectionView.reloadData()
        updateDetail()
    }
}

final class CalendarDayCell: UICollectionViewCell {
    static let reuseID = "CalendarDayCell"

    private let circle = UIView()
    private let numberLabel = UILabel()
    private let dot = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        circle.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        dot.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = .systemFont(ofSize: 16, weight: .medium)
        numberLabel.textAlignment = .center
        dot.layer.cornerRadius = 2.5
        contentView.addSubview(circle)
        contentView.addSubview(numberLabel)
        contentView.addSubview(dot)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -3),
            circle.widthAnchor.constraint(equalToConstant: 34),
            circle.heightAnchor.constraint(equalToConstant: 34),
            numberLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            dot.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: 1),
            dot.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            dot.widthAnchor.constraint(equalToConstant: 5),
            dot.heightAnchor.constraint(equalToConstant: 5)
        ])
        circle.layer.cornerRadius = 17
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configureBlank() {
        numberLabel.text = ""
        circle.backgroundColor = .clear
        circle.layer.borderWidth = 0
        dot.isHidden = true
    }

    func configure(number: Int, isToday: Bool, isSelected: Bool, isCompleted: Bool, isScheduled: Bool) {
        numberLabel.text = "\(number)"
        circle.layer.borderWidth = 0
        dot.isHidden = true

        if isCompleted {
            circle.backgroundColor = AppTheme.green
            numberLabel.textColor = .white
        } else if isSelected {
            circle.backgroundColor = AppTheme.navy
            numberLabel.textColor = .white
        } else {
            circle.backgroundColor = .clear
            numberLabel.textColor = isScheduled ? .label : .tertiaryLabel
            if isToday {
                circle.layer.borderWidth = 2
                circle.layer.borderColor = AppTheme.navy.cgColor
            }
            if isScheduled {
                dot.isHidden = false
                dot.backgroundColor = AppTheme.blue
            }
        }
    }
}

// MARK: - Program browse

final class ProgramViewController: BaseViewController {
    private var stack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Program"
        (_, stack) = makeScrollView()
        stack.addArrangedSubview(label("CHP APP PREP", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        stack.addArrangedSubview(label("Browse the full schedule. Tap a month, then a week, to view sessions. Mark days complete from the Calendar.", color: .secondaryLabel))
        for month in store.months {
            let button = UIButton(type: .system)
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
            button.setTitle("Month \(month.number)  ·  \(month.title)", for: .normal)
            button.setTitleColor(AppTheme.navy, for: .normal)
            button.addAction(UIAction { [weak self] _ in
                self?.navigationController?.pushViewController(WeeksViewController(month: month), animated: true)
            }, for: .touchUpInside)
            stack.addArrangedSubview(card(wrapping: button, insets: UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)))
        }
    }
}

final class WeeksViewController: BaseViewController {
    private let month: TrainingMonth

    init(month: TrainingMonth) {
        self.month = month
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil    // pushed screen keeps the back button
        title = "Month \(month.number)"
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label(month.title, font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        for week in month.weeks {
            let button = UIButton(type: .system)
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
            button.setTitle("Week \(week.number)  ·  \(week.title)", for: .normal)
            button.setTitleColor(AppTheme.navy, for: .normal)
            button.addAction(UIAction { [weak self] _ in
                self?.navigationController?.pushViewController(WeekViewController(week: week), animated: true)
            }, for: .touchUpInside)
            stack.addArrangedSubview(card(wrapping: button, insets: UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)))
        }
    }
}

final class WeekViewController: BaseViewController {
    private let week: TrainingWeek

    init(week: TrainingWeek) {
        self.week = week
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        title = "Week \(week.number)"
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label(week.title, font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        for workout in week.workouts {
            let days = workout.weekdays.map { $0.short }.joined(separator: " · ")
            let title = UIButton(type: .system)
            title.contentHorizontalAlignment = .left
            title.titleLabel?.font = .preferredFont(forTextStyle: .headline)
            title.setTitle(workout.title, for: .normal)
            title.setTitleColor(AppTheme.navy, for: .normal)
            title.addAction(UIAction { [weak self] _ in
                self?.navigationController?.pushViewController(WorkoutDetailViewController(workout: workout, date: nil), animated: true)
            }, for: .touchUpInside)
            let subtitle = label("\(workout.focus)  •  \(workout.duration)  •  \(days)", color: .secondaryLabel)
            let content = UIStackView(arrangedSubviews: [title, subtitle])
            content.axis = .vertical
            content.spacing = 6
            stack.addArrangedSubview(card(wrapping: content))
        }
    }
}

final class WorkoutDetailViewController: BaseViewController {
    private let workout: Workout
    private let date: Date?
    private var completeButton: UIButton!

    /// `date` is the calendar day being trained. When nil, the screen is reference-only.
    init(workout: Workout, date: Date?) {
        self.workout = workout
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        title = workout.title
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label(workout.focus, font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        let days = workout.weekdays.map { $0.short }.joined(separator: " · ")
        stack.addArrangedSubview(label("\(workout.duration)  •  \(days)", color: .secondaryLabel))

        for exercise in workout.exercises {
            let rowStack = UIStackView(arrangedSubviews: [
                label(exercise.name, font: .preferredFont(forTextStyle: .headline)),
                label("\(exercise.category)  •  \(exercise.prescription)", color: .secondaryLabel)
            ])
            rowStack.axis = .vertical
            rowStack.spacing = 5
            stack.addArrangedSubview(card(wrapping: rowStack, insets: UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)))
        }

        if date != nil {
            completeButton = button(title: "", action: #selector(toggleComplete))
            completeButton.accessibilityIdentifier = "workout.complete"
            stack.addArrangedSubview(completeButton)
            updateCompleteButton()
        } else {
            stack.addArrangedSubview(label("Open this session from the Calendar to mark the day complete.", color: .secondaryLabel))
        }
    }

    @objc private func toggleComplete() {
        guard let date else { return }
        store.setCompleted(!store.isCompleted(on: date), on: date)
        updateCompleteButton()
    }

    private func updateCompleteButton() {
        guard let date, let completeButton else { return }
        let done = store.isCompleted(on: date)
        completeButton.setTitle(done ? "Mark as incomplete" : "Mark session complete", for: .normal)
        completeButton.configuration?.baseBackgroundColor = done ? AppTheme.green : AppTheme.navy
    }
}

// MARK: - Custom

final class CustomWorkoutsViewController: BaseViewController {
    private var stack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom"
        (_, stack) = makeScrollView()
        rebuild()
    }

    override func storeDidChange() { rebuild() }

    private func rebuild() {
        guard stack != nil else { return }
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stack.addArrangedSubview(label("Your Workouts", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        stack.addArrangedSubview(label("Add sessions that complement your CHP prep schedule.", color: .secondaryLabel))
        stack.addArrangedSubview(button(title: "Create custom workout", action: #selector(createWorkout)))
        for name in store.customWorkoutNames {
            let rowLabel = label(name, font: .preferredFont(forTextStyle: .headline))
            stack.addArrangedSubview(card(wrapping: rowLabel))
        }
    }

    @objc private func createWorkout() {
        let alert = UIAlertController(title: "New workout", message: "Give your custom session a name.", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "e.g. Hill sprints" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
            guard let name = alert?.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return }
            self?.store.addCustomWorkout(named: name)
        })
        present(alert, animated: true)
    }
}

// MARK: - Progress

final class ProgressViewController: BaseViewController {
    private var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Progress"
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label("Keep showing up.", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        progressLabel = label("", font: .preferredFont(forTextStyle: .headline))
        stack.addArrangedSubview(progressLabel)
        let note = label("Consistency is the goal. Open a day from the Calendar, then mark it complete when you finish.", color: .secondaryLabel)
        stack.addArrangedSubview(card(wrapping: note))
        updateProgress()
    }

    override func storeDidChange() { updateProgress() }

    private func updateProgress() {
        progressLabel?.text = "\(store.completedCount) of \(store.totalScheduledDays) scheduled sessions complete"
    }
}

// MARK: - Fitness Log

final class FitnessLogViewController: BaseViewController {
    private let fields = ["Weight", "Body Fat", "Push-Ups", "Sit-Ups", "300m Run", "1.5 Mile Run", "Notes"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fitness Log"
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label("Monthly Fitness Log", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        stack.addArrangedSubview(label("Record your numbers at the end of each month, just like the booklet's log page.", color: .secondaryLabel))

        for month in store.months {
            let monthStack = UIStackView()
            monthStack.axis = .vertical
            monthStack.spacing = 12
            monthStack.addArrangedSubview(label("Month \(month.number) · \(month.title)", font: .preferredFont(forTextStyle: .headline), color: AppTheme.navy))
            for field in fields {
                monthStack.addArrangedSubview(makeField(month: month.number, field: field))
            }
            stack.addArrangedSubview(card(wrapping: monthStack))
        }
    }

    private func makeField(month: Int, field: String) -> UIView {
        let caption = label(field, font: .preferredFont(forTextStyle: .caption1), color: AppTheme.blue)
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = store.logValue(month: month, field: field)
        textField.placeholder = field == "Notes" ? "Notes…" : "—"
        textField.accessibilityIdentifier = "log.m\(month).\(field)"
        textField.addAction(UIAction { [weak self, weak textField] _ in
            self?.store.setLogValue(textField?.text ?? "", month: month, field: field)
        }, for: .editingDidEnd)
        let row = UIStackView(arrangedSubviews: [caption, textField])
        row.axis = .vertical
        row.spacing = 4
        return row
    }
}

// MARK: - Settings

final class SettingsViewController: BaseViewController {
    private var startLabel: UILabel!

    private let longDate: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE, MMM d, yyyy"; return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        let (_, stack) = makeScrollView()
        stack.addArrangedSubview(label("CHP Tracker", font: .preferredFont(forTextStyle: .title2), color: AppTheme.navy))
        stack.addArrangedSubview(label("Your training data is stored on this device. The schedule follows the CHP APP Preparation booklet.", color: .secondaryLabel))

        // Program start date
        let startStack = UIStackView()
        startStack.axis = .vertical
        startStack.spacing = 8
        startStack.addArrangedSubview(label("PROGRAM START (WEEK 1, DAY 1)", font: .preferredFont(forTextStyle: .caption1), color: AppTheme.blue))
        startLabel = label("", font: .preferredFont(forTextStyle: .headline))
        startStack.addArrangedSubview(startLabel)
        startStack.addArrangedSubview(label("Week 1 begins on the Sunday of the week you pick.", color: .secondaryLabel))
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.date = store.programStartDate
        picker.addAction(UIAction { [weak self, weak picker] _ in
            guard let self, let picker else { return }
            self.store.programStartDate = picker.date
            self.updateStartLabel()
        }, for: .valueChanged)
        startStack.addArrangedSubview(picker)
        stack.addArrangedSubview(card(wrapping: startStack))
        updateStartLabel()

        let reset = button(title: "Reset completed sessions", action: #selector(resetProgress))
        reset.configuration?.baseBackgroundColor = .systemRed
        stack.addArrangedSubview(reset)
    }

    private func updateStartLabel() {
        startLabel?.text = longDate.string(from: store.programStartDate)
    }

    @objc private func resetProgress() {
        let alert = UIAlertController(title: "Reset progress?", message: "This will uncheck every completed session.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.store.resetCompletion()
        })
        present(alert, animated: true)
    }
}
