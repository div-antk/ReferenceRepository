//
//  ViewModel.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInputs {
    
}

protocol ViewModelOutputs {
    
}

protocol ViewModelType {
    var inputs: ViewModelInputs {get}
    var outputs: ViewModelOutputs {get}
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    
    //MARK: -input
    
    //MARK: -output
    
    //MARK: -other
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }

}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs {return self}
    var outputs: ViewModelOutputs {return self}
}
