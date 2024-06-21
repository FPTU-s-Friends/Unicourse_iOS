//
//  SupportContactView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import MapKit
import SwiftUI

struct SupportContactView: View {
    @Environment(\.presentationMode) var presentationMode

    // Define the map region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 10.8411, longitude: 106.8099),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    struct MapLocation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    private var locations = [
        MapLocation(coordinate: CLLocationCoordinate2D(latitude: 10.8411, longitude: 106.8099))
    ]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Contact Us")) {
                    Text("For any inquiries or support, feel free to reach out to us through the provided email or phone number. We are here to assist you!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10) // Add some space below the description

                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                        Text("unicourse.learningplatform@gmail.com")
                            .font(.system(size: 14, weight: .semibold))
                    }

                    // Using Link for phone number
                    Link(destination: URL(string: "tel:+84942833463")!) {
                        HStack {
                            Image(systemName: "phone.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24)
                                .foregroundColor(.green)
                            Text("+84 94 283 34 63")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                }

                Section(header: Text("Position")) {
                    VStack {
                        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, annotationItems: locations) { location in
                            // Use MapAnnotation for better customization
                            MapAnnotation(coordinate: location.coordinate) {
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 40)
                                    .foregroundColor(.blue)
                                    .shadow(radius: 5)
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .cornerRadius(10)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .padding(.horizontal, -5)
                }
            }
        }
        .navigationTitle("Contact Support")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    SupportContactView()
}
