//
//  DummyData.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
class DummyData {
    static func fetchVideo() -> [Video] {
        let channel = Channel(imageURL: "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=545&q=80", name: "hanhnguyen")
        let video1 = Video(imageURL: "https://images.unsplash.com/photo-1519669556878-63bdad8a1a49?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80", title: "CES vs. VGA | EVS vs. GAM (Bo3) - VCS Mùa Xuân 2020 - W2D1", channel: channel, view: "215 N lượt xem", createdTime: Date())

        let video2 = Video(imageURL: "https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                           title: "NHẠC TRẺ REMIX 2020 HAY NHẤT HIỆN NAY ❤️ EDM Tik Tok Htrol Remix lk nhac tre remix gây nghiện 2020", channel: channel, view: "215 Tr lượt xem", createdTime: Date())
        return [video1, video2]
    }
}
