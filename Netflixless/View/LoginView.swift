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
    @State var email: String = ""
    @State var password: String = ""
    @State var alert = false
    @State var createAccount = false
    @State var showError = false
    @State var errorMsg = ""
    @State var isLoading = false
    
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl:URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""
    
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
                TextField("Email", text: $email)
                    .padding()
                    .background(.ultraThickMaterial)
                                    
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(.ultraThickMaterial)
                
                Button(action: {
                    login()
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
                    createAccount.toggle()
                }) {
                    Text("Doesn't have an account yet ?\nNo worries you can just create your acoount here.\n")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
                    
                Button(action: {resetPassword() }) {
                    Text("Forgot your password ?")
                        .font(.subheadline)
                    .foregroundStyle(.gray)
                }
                    
                Spacer()
            }.overlay{
                LoadingView(showing: $isLoading)
            }                .fullScreenCover(isPresented: $createAccount, content: {
                    SignView()
                })
                .alert(errorMsg, isPresented: $showError) {}
                .padding()
        }
    }
    func login()  {
        isLoading = true
        Task {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("User:\(email) found")
                try await fetchUser()
            }catch {
               await displayErrorMsg(error)
            }
        }
    }
    func resetPassword() {
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
            }catch {
                await displayErrorMsg(error)
            }
        }
    }
    func displayErrorMsg(_ error: Error) async {
        await MainActor.run(body: {
            errorMsg = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    func fetchUser() async throws{
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        await MainActor.run {
            userpseudo = user.username
            self.userUID = userID
            imageUrl = user.pictureURL
            isLogged = true
        }
    }
        
}
struct SignView: View {
    @State var email: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var ProfilePic:Data? 
    @State var showImagePicker = false
    @State var photoItem:PhotosPickerItem?
    @State var showError = false
    @State var errorMsg = ""
    @State var isLoading = false
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl:URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""
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
                    if let ProfilePic, let image = UIImage(data: ProfilePic){
                        Image(uiImage: image).resizable().aspectRatio( contentMode: .fill)
                    }else {
                        Image( "netflixUser").resizable().aspectRatio(contentMode: .fill)
                    }
                }.frame(width: 85, height: 85)
                    .clipShape(Rectangle())
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                    .contentShape(Circle())
                TextField("Username", text: $userName)
                                  .padding()
                                  .background(.ultraThickMaterial)
                              
                TextField("Email", text: $email)
                    .padding()
                    .background(.ultraThickMaterial)
              
                SecureField("Password", text: $password)
                    .padding()
                    .background(.ultraThickMaterial)
                
                SecureField("Password", text: $password2)
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
        }.overlay{
            LoadingView(showing: $isLoading)
        }         .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
            .onChange(of: photoItem) { newValue in
                if let newValue {
                    Task {
                        do {
                            guard let imageData = try await newValue.loadTransferable(type: Data.self) else {return}
                            
                            await MainActor.run(body: {
                                ProfilePic = imageData
                            })
                        }catch {
                            
                        }
                    }
                }
            }
            .alert(errorMsg,isPresented: $showError) {
                
            }
    }
    func signButton() -> some View {
        Button(action: {
            registerAccount()
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
        }).isAllowed(condition())
    }
    func condition() -> Bool {
        userName == "" || email == "" || password == "" || password != password2 || password.count <= 8
    }
    func registerAccount(){
        isLoading = true
        Task {
            do {
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                
                guard let userID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = ProfilePic else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userID)
                let _ = try await storageRef.putDataAsync(imageData )
                let downloadUrl = try await storageRef.downloadURL()
                let user = User(userUID: userID, username: userName, email: email, pictureURL: downloadUrl, password: password, favorites: nil)
                
                let _ =  try Firestore.firestore().collection("Users").document(userID).setData(from: user,completion: { Err in
                    if Err == nil {
                        print("Saved successfully")
                        userpseudo = userName
                        self.userUID = userID
                        imageUrl = downloadUrl
                        isLogged = true
                    }
                })
            }catch {
                try await Auth.auth().currentUser?.delete()
              await  displayErrorMsg(error)
                
            
            }
        }
    }
    func displayErrorMsg(_ error: Error)async {
        await MainActor.run(body: {
            errorMsg = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
}
#Preview {
    ContentView()
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
