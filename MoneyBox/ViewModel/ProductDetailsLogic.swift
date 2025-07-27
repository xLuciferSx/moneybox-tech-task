//
//  ProductDetailsLogic.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import ComposableArchitecture
import Networking

@Reducer
public struct ProductDetailsLogic {
  @ObservableState
  public struct State: Equatable {
    var product: ProductResponse?
  }
  
  public enum Action: Equatable, Sendable, BindableAction {
    case addMoney
    case binding(BindingAction<State>)
  }
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .addMoney:
          return .none
        case .binding:
          return .none
      }
    }
  }
}
