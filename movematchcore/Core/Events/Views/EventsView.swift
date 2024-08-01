import SwiftUI

struct EventsView: View {
    @State private var showFilterModal: Bool = false
    @State private var showCalendarModal: Bool = false
    @State private var events: [Event] = [sampleEvent]
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @Namespace private var animation

    var filteredEvents: [Event] {
        events.filter { isSameDate($0.startDate, currentDate) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Events")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink(destination: CreateEventView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Button(action: {
                            showFilterModal.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Button(action: {
                            showCalendarModal.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .frame(width: 350, height: 50)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                Divider()
                
                // Month and Year
                Text(currentDate.format("MMMM yyyy"))
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                // Week Slider
                TabView(selection: $currentWeekIndex) {
                    ForEach(weekSlider.indices, id: \.self) { index in
                        let week = weekSlider[index]
                        weekView(week)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 90)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .onAppear {
                    initializeWeekSlider()
                }
                .onChange(of: currentWeekIndex) { newValue in
                    handleWeekChange(newIndex: newValue)
                }

                // Event Cards
                ScrollView {
                    if filteredEvents.isEmpty {
                        VStack {
                            PlaceholderView(text: "Wake Up", time: "6:00 AM", color: .orange)
                            VStack {
                                Image(systemName: "flag")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                            Text("No upcoming events")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Button(action: {
                                // Create Event action
                            }) {
                                Text("Create Event")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                            }.frame(width: 300, height: 300)
                            PlaceholderView(text: "Sleep", time: "9:00 PM", color: .blue)
                        }
                    } else {
                        VStack {
                            PlaceholderView(text: "Wake Up", time: "6:00 AM", color: .orange)
                            ForEach(filteredEvents) { event in
                                HStack {
                                    VStack {
                                        ZStack {
                                            Text(event.time)
                                                .font(.system(size: 10, weight: .semibold))
                                        }
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: 3)
                                            .cornerRadius(10)
                                    }
                                    NavigationLink(destination: EventDetailView(event: event)) {
                                        EventCardView(event: event)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 10)
                                            .foregroundColor(.black)
                                    }
                                }.padding(.leading, 25)
                            }
                            PlaceholderView(text: "Sleep", time: "9:00 PM", color: .blue)
                        }
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showFilterModal) {
                FilterModalView()
            }
            .sheet(isPresented: $showCalendarModal) {
                CalendarModalView(selectedDate: $currentDate, onSelectDate: updateWeekSlider)
            }
        }
    }

    // Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .black)
                        .background(content: {
                            if isSameDate(day.date, currentDate) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.purple)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        })
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 15 && (currentWeekIndex == 0 || currentWeekIndex == weekSlider.count - 1) {
                            paginateWeek()
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                currentWeekIndex += 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }

    func handleWeekChange(newIndex: Int) {
        if newIndex == 0 {
            if let firstDate = weekSlider.first?.first?.date {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                currentWeekIndex += 1
            }
        } else if newIndex == weekSlider.count - 1 {
            if let lastDate = weekSlider.last?.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }

    func initializeWeekSlider() {
        if weekSlider.isEmpty {
            let currentWeek = Date().fetchWeek()
            weekSlider.append(currentWeek)
            if let firstDate = currentWeek.first?.date {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
            }
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }

    func updateWeekSlider(to date: Date) {
        currentDate = date
        let newWeek = date.fetchWeek()
        weekSlider = [newWeek]
        currentWeekIndex = 1
        if let firstDate = newWeek.first?.date {
            weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
        }
        if let lastDate = newWeek.last?.date {
            weekSlider.append(lastDate.createNextWeek())
        }
    }
}

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct PlaceholderView: View {
    let text: String
    let time: String
    let color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 50)
                .cornerRadius(50)
                .foregroundColor(color)
            Text("\(text) at \(time)")
                .foregroundColor(.white)
        }
        .padding(.bottom, 10)
    }
}

struct EventPageView: View {
    let event: Event
    var body: some View {
        Text("Event Page View: \(event.title)")
    }
}

struct FilterModalView: View {
    var body: some View {
        Text("Filter Modal View")
    }
}

struct CalendarModalView: View {
    @Binding var selectedDate: Date
    var onSelectDate: (Date) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            HStack {
                Button("Today") {
                    selectedDate = Date()
                }
                .padding()
                Spacer()
                Button("Done") {
                    onSelectDate(selectedDate)
                    dismiss()
                }
                .padding()
            }
            .padding()
        }
    }
}

struct EditEventView: View {
    let event: Event
    
    var body: some View {
        VStack {
            Text("Edit Event")
            Text(event.title)
        }
    }
}

struct EventCardView: View {
    let event: Event
    @State private var showEditModal: Bool = false
    @State private var showActionModal: Bool = false

    var body: some View {
        VStack() {
            HStack(alignment: .center, spacing: 15) {
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(event.title)
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                        Button(action: {
                            showActionModal.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 20, height: 5)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Text("\(event.time) • \(event.location)")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    HStack {
                        ZStack {
                            ForEach(0..<min(event.attendees.count, 3), id: \.self) { index in
                                        Color.gray
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                            .offset(x: CGFloat(index * 20))
                            }
                            if event.attendees.count > 3 {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("+\(event.attendees.count - 3)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                                    .offset(x: CGFloat(3 * 20))
                            }
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.black).opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .sheet(isPresented: $showActionModal) {
                    EventActionModalView(event: event)
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showEditModal) {
            EditEventView(event: event)
        }
    }
}

struct EventActionModalView: View {
    let event: Event
    
    var body: some View {
        VStack {
            Text("Edit Event")
            Text(event.title)
            // Additional actions and UI for editing, rescheduling, and deleting the event
        }
    }
}

func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
    return Calendar.current.isDate(date1, inSameDayAs: date2)
}

struct Attendee {
    let profileImageUrl: String
}

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // Checking Whether the date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    // Fetching Week based on given date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekDate = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard let start = weekDate?.start else {
            return []
        }
        
        // Iterating to get the full week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: start) {
                week.append(.init(date: weekDay))
            }
        }
        
        return week
    }
    
    // Creating next week, based on the last current week date
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
    // Creating Previous week, based on the first current week date
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: -1, to: startOfLastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}

#Preview {
    EventsView()
}
