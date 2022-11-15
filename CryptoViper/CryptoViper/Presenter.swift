//
//  Presenter.swift
//  CryptoViper
//
//  Created by Bertuğ Horoz on 15.11.2022.
//

import Foundation

enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter{
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter{
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try Again Later")
        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    
}
