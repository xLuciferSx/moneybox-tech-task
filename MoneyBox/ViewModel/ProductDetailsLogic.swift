//
//  ProductDetailsLogic.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import ComposableArchitecture
import Factory
import Networking

@Reducer
public struct ProductDetailsLogic {
  @Injected(\.accountManager) private var accountManager

  @ObservableState
  public struct State: Equatable {
    var product: ProductResponse?
    var amountString: String = ""
    var isLoading: Bool = false
    var alertMessage: String? = nil
    var showAlert: Bool = false
    var didAddMoneySuccessfully = false
  }

  public enum Action: Equatable, Sendable, BindableAction {
    case addMoney
    case dismissAlert
    case addMoneyResponse(TaskResult<OneOffPaymentResponse>)
    case binding(BindingAction<State>)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
        case .addMoney:
          guard let productID = state.product?.id,
                let amount = state.amountString.intValue else { return .none }
          state.isLoading = true
          return .run { send in
            await send(
              .addMoneyResponse(
                TaskResult {
                  try await accountManager.addMoney(amount: amount, to: productID)
                }
              )
            )
          }
          
        case .addMoneyResponse(.success):
          state.isLoading = false
          state.alertMessage = "money_added_succesfully".localized
          state.showAlert = true
          state.didAddMoneySuccessfully = true
          return .none
          
        case let .addMoneyResponse(.failure(error)):
          state.isLoading = false
          state.showAlert = true
          state.alertMessage = error.localizedDescription
          return .none
          
        case .dismissAlert:
          state.alertMessage = nil
          state.showAlert = false
          return .none
          
        case .binding:
          return .none
      }
    }
  }
}
