import Foundation

protocol TrackersServiceDelegate: AnyObject {
  func updateTrackers()
}

final class TrackersService {
  static let shared = TrackersService()
  weak var delegate: TrackersServiceDelegate?

  private let trackerCategoryStore = TrackerCategoryStore()
  private var trackerRecordStore = TrackerRecordStore()

  private(set) var categoryExample: [TrackerCategory] = [TrackerCategory(
    title: "Важное",
    trackers: [])
  ]

  func getCategoriesCount() -> Int {
    trackerCategoryStore.numberOfSections
  }

  func getCategoriesExampleCount() -> Int {
    return categoryExample.count
  }

  func addTracker(tracker: Tracker, for category: String) {
    trackerCategoryStore.addTrackerToCategory(tracker, category: category)
    delegate?.updateTrackers()
  }

  func addCategory(_ category: TrackerCategory) {
    trackerCategoryStore.addCategory(category)
  }

  func getVisibleCategoriesForDate(_ selectedDate: Date, recordTracker: Set<TrackerRecord>) -> [TrackerCategory] {
    let weekday = Calendar.current.component(.weekday, from: selectedDate)
    let filterWeekday = weekday == 1 ? 7 : weekday - 1
    let fecthTrackers = fetchCategories()
    var allVisibleCategories = [TrackerCategory]()

    allVisibleCategories = fecthTrackers.compactMap { category in
      let allFilteredTrackers = category.trackers.filter { tracker in
        tracker.schedule.contains { weekday in
          return weekday.rawValue == filterWeekday
        }
      }

      let filteredEventTrackers = allFilteredTrackers.filter { tracker in
        if !tracker.isHabit {
          let isEventRecordOnDate = recordTracker.contains { trackerRecord in
            return trackerRecord.date == selectedDate && trackerRecord.id == tracker.id
          }

          let isNotEventRecord = recordTracker.allSatisfy { trackerRecord in
            return trackerRecord.id != tracker.id
          }

          return isEventRecordOnDate || isNotEventRecord
        }

        return true
      }

      if filteredEventTrackers.isEmpty {
        return nil
      }

      return TrackerCategory(title: category.title, trackers: filteredEventTrackers)
    }

    return allVisibleCategories
  }

  func addRecord(_ record: TrackerRecord) {
    trackerRecordStore.addRecord(record)
  }

  func deleteRecord(_ record: TrackerRecord) {
    trackerRecordStore.deleteRecord(record)
  }

  func fetchRecords() -> Set<TrackerRecord> {
    trackerRecordStore.fetchRecords()
  }

  private init() { }

  private func fetchCategories() -> [TrackerCategory] {
    let categories = try? trackerCategoryStore.fetchCategories()
    guard let categories else {
      print("Do not fetch Categories")
      return []
    }
    return categories
  }

}
