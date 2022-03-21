//
//  Partner.swift
//  Partner
//
//  Created by Saamer Mansoor on 2/16/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct PartnerEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color(hex: 0x014579)
                .ignoresSafeArea()
            HStack{
                ZStack{
                    Color(hex: 0xFFFFFF)
                    Image("Logo")
                        .resizable()
                        .padding(.all)
                        .scaledToFit()
                        .clipped()
                }
                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                    if let name = userDefaults.string(forKey: "state")
                    {
                        if name == "transcribing"
                        {
                            VStack{
                                Text("Speech")
                                    .font(Font.custom("Avenir", size: 16))
                                
                                    .fontWeight(.black)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                                Text("Transcribing")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                            }
                            .padding(.horizontal)
                            Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color(hex: 0xFFFFFF))
                                .padding(.trailing)
                        }
                        else if name == "noise alert"
                        {
                            VStack{
                                Text("Noise Alert")
                                    .font(Font.custom("Avenir", size: 16))
                                
                                    .fontWeight(.black)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                                Text("On")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                            }
                            .padding(.horizontal)
                            Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color(hex: 0xFFFFFF))
                                .padding(.trailing)
                        }
                        else
                        {
                            VStack{
                                Text("Noise Alert")
                                    .font(Font.custom("Avenir", size: 16))
                                
                                    .fontWeight(.black)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                                Text("Stopped")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: 0xFFFFFF))
                            }
                            .padding(.horizontal)
                            Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color(hex: 0xFFFFFF))
                                .padding(.trailing)
                        }
                    }
                    else{
                        VStack{
                            Text("Noise Alert")
                                .font(Font.custom("Avenir", size: 16))
                            
                                .fontWeight(.black)
                                .foregroundColor(Color(hex: 0xFFFFFF))
                            Text("Stopped")
                                .font(Font.custom("Avenir", size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: 0xFFFFFF))
                        }
                        .padding(.horizontal)
                        Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                            .foregroundColor(Color(hex: 0xFFFFFF))
                            .padding(.trailing)
                    }
                }
                else{
                    VStack{
                        Text("Noise Alert")
                            .font(Font.custom("Avenir", size: 16))
                        
                            .fontWeight(.black)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                        Text("Stopped")
                            .font(Font.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                    }
                    .padding(.horizontal)
                    Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color(hex: 0xFFFFFF))
                        .padding(.trailing)
                }
            }
        }
    }
}

@main
struct Partner: Widget {
    let kind: String = "Partner"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PartnerEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .supportedFamilies([.systemMedium])
        .description("This is an example widget.")
    }
}

struct Partner_Previews: PreviewProvider {
    static var previews: some View {
        PartnerEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
