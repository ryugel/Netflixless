//
//  LoginView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 12/02/2024.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Netflixless")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.red)
                Divider()
                Text("WATCH\nTV SHOWS &\nMOVIES\nANYWHERE.\nANYTIME.")
                    .bold()
                    .font(.largeTitle)
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(.ultraThickMaterial)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.ultraThickMaterial)
                
                Button(action: {
                    viewModel.login()
                }, label: {
                    Text("Sign In")
                        .padding()
                        .foregroundStyle(.white)
                        .font(.callout)
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 0, height: 0), style: .continuous)
                                .foregroundStyle(.red)
                                .frame(width: 330)
                        )
                        .padding()
                        .padding(.leading, 119)
                })
                Button(action: {
                    viewModel.createAccount.toggle()
                }) {
                    Text("Doesn't have an account yet ?\nNo worries you can just create your acoount here.\n")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
                
                Button(action: {
                    viewModel.resetPassword()
                }) {
                    Text("Forgot your password ?")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }.alert("Link sent", isPresented: $viewModel.alert) {}
                
                Spacer()
            }
            .overlay {
                LoadingView(showing: $viewModel.isLoading)
            }
            .fullScreenCover(isPresented: $viewModel.createAccount, content: {
                              SignView()
                          })
            .padding()
        }
        .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {}
    }
}

struct SignView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Netflixless")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.red)
                Divider()
                ZStack {
                    if let ProfilePic = viewModel.ProfilePic, let image = UIImage(data: ProfilePic) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image("netflixUser")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 85, height: 85)
                .clipShape(Rectangle())
                .onTapGesture {
                    viewModel.showImagePicker.toggle()
                }
                .contentShape(Circle())
                
                TextField("Username", text: $viewModel.userName)
                    .padding()
                    .background(.ultraThickMaterial)
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(.ultraThickMaterial)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.ultraThickMaterial)
                
                SecureField("Password", text: $viewModel.password2)
                    .padding()
                    .background(.ultraThickMaterial)
                
                signButton()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account ?\nClick to sign in.\n")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
            }
        }
        .overlay {
            LoadingView(showing: $viewModel.isLoading)
        }
        .photosPicker(isPresented: $viewModel.showImagePicker, selection: $viewModel.photoItem)
        .onChange(of: viewModel.photoItem) { newValue in
            if let newValue = newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                        viewModel.ProfilePic = imageData
                    } catch {
                        
                    }
                }
            }
        }
        .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {}
    }
    
    func signButton() -> some View {
        Button(action: {
            viewModel.registerAccount()
        }, label: {
            Text("Sign In")
                .padding()
                .foregroundStyle(.white)
                .font(.callout)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 0, height: 0), style: .continuous)
                        .foregroundStyle(.red)
                        .frame(width: 330)
                )
                .padding()
        }).isAllowed(viewModel.condition())
    }
}

extension View {
    func isAllowed(_ condition: Bool) -> some View {
        self.disabled(condition).opacity(condition ? 0.6:1)
    }
}

struct LoadingView: View {
    @Binding var showing: Bool
    
    var body: some View {
        ZStack {
            if showing {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                Group {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(1.5)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showing)
    }
}
