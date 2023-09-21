//
//  ProfileViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation
import Combine
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var profileImage: Image?
    @Published var selectImage: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    private var uiImage: UIImage?
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        setupSubsribers()
    }
    
    private func setupSubsribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellable)
    }
    
    @MainActor
    func loadImage() async throws {
        guard let item = selectImage else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let image = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: image)
    }
    
    func updataUserData() async throws {
        try await updateProfileImage()
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserPhotoProfile(withImageUrl: imageUrl)
    }
}
