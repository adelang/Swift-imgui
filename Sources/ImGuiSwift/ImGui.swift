//
//  ImGui.swift
//  Swift-imgui
//
//  Created by Hiroaki Yamane on 5/13/17.
//  Copyright © 2017 Hiroaki Yamane. All rights reserved.
//

public class ImGui {
    
    public enum API {
        case metal
        case opengl
    }
    
    public static var vc: ViewControllerAlias?
    public class func initialize(_ api: API = .opengl, font: String? = nil) {
        switch api {
        case .metal:
            vc = ImGuiMTKViewController(fontName: font)
            if let vc = vc as? ImGuiMTKViewController {
                if !vc.isAvailable {
                    print("Metal API is not available, falling back to OpenGL API.")
                    initialize(.opengl, font: font)
                }
            }
        break
        case .opengl:
            #if os(iOS)
            vc = ImGuiGLKViewController(fontName: font)
            #endif
        break
        default:
            break
        }
    }
    
    public class func draw(_ block: @escaping ImGuiDrawCallback) {
        if var vc = vc as? ImGuiViewControllerProtocol {
            vc.drawBlocks.append(block)
        }
    }
}
