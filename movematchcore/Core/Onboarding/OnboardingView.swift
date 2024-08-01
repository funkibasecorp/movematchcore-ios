import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isActive = false

    let onboardingData = [
        OnboardingData(title: "Welcome to SpotMatch!", description: "Where we're on a mission to make fitness fun, inclusive, and a part of your daily vibe. Let's get moving, together!", imageName: "welcome_1"),
        OnboardingData(title: "Meet Spotty", description: "Embark on a journey to wellness with SpotMatch and your guide, Spotty!", imageName: "welcome_2"),
        OnboardingData(title: "The Silent Threat", description: "Explains the dangers of physical inactivity and its impact on health.", imageName: "welcome_3"),
        OnboardingData(title: "Why It Matters", description: "Details the importance of physical activity for quality of life and prevention of diseases.", imageName: "welcome_4"),
        OnboardingData(title: "A Loss of Money", description: "Highlights the financial costs associated with physical inactivity and related health issues.", imageName: "welcome_5"),
        OnboardingData(title: "A Loss of Health", description: "Describes the health consequences of a sedentary lifestyle.", imageName: "welcome_6"),
        OnboardingData(title: "A Loss of Life", description: "Discusses the mortality risks linked to inactivity.", imageName: "welcome_7"),
        OnboardingData(title: "Starts with Our Minds", description: "Explores the mental aspects influencing physical activity, including body image and motivation.", imageName: "welcome_8"),
        OnboardingData(title: "Impact of Environment", description: "Explains how socioeconomic status and environmental conditions affect physical activity.", imageName: "welcome_9"),
        OnboardingData(title: "Sedentary Lifestyle", description: "Talks about how modern technology contributes to a sedentary lifestyle.", imageName: "welcome_10"),
        OnboardingData(title: "Activity Level Assessment", description: "How active are you currently? Your journey starts wherever you are.", imageName: "welcome_11"),
        OnboardingData(title: "Screen Time Access", description: "Requests permission to access screen time data to tailor activity recommendations.", imageName: "welcome_12"),
        OnboardingData(title: "Progress Calculation", description: "Shows the potential weight loss from substituting screen time with exercise.", imageName: "welcome_13"),
        OnboardingData(title: "Community Encouragement", description: "Emphasizes the community aspect of the app to motivate and sustain fitness routines.", imageName: "welcome_14"),
        OnboardingData(title: "Body Confidence", description: "Encourages users to celebrate their fitness journey and achievements.", imageName: "welcome_15"),
        OnboardingData(title: "Get Moving", description: "Motivates users to engage in daily physical activity with fun elements and rewards.", imageName: "welcome_16"),
        OnboardingData(title: "Premium Plan Introduction", description: "Introduces the premium membership plan.", imageName: "welcome_17")
    ]

    var body: some View {
        ZStack {
            if isActive {
                TabBarView()
                    .transition(.opacity)
            } else {
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<onboardingData.count, id: \.self) { index in
                            OnboardingPageView(data: onboardingData[index])
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .animation(.easeInOut, value: currentPage)

                    Button(action: {
                        if currentPage < onboardingData.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }) {
                        Text(currentPage == onboardingData.count - 1 ? "Get Started" : "Next")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    .animation(.easeInOut, value: currentPage)
                }
            }
        }
    }
}

struct OnboardingData {
    let title: String
    let description: String
    let imageName: String
}

struct OnboardingPageView: View {
    let data: OnboardingData

    var body: some View {
        VStack {
            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .padding()
                .animation(.easeInOut(duration: 1.0), value: data.imageName)

            Text(data.title)
                .font(.largeTitle)
                .bold()
                .padding()
                .animation(.easeInOut(duration: 1.0), value: data.title)

            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .animation(.easeInOut(duration: 1.0), value: data.description)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
