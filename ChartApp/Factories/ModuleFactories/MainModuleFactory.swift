//
//  MainModuleFactory.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

class MainModuleFactory: MainModuleFactoring {
    func makeEnterCountModule() -> EnterCountViewInput & EnterCountViewOutput {
        return EnterCountViewController()
    }
}
