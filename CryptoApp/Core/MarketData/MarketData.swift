//
//  MarketData.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import Foundation
import SwiftUI

// JSON Data for MarketData /global request
/*
 * URL: https://api.coingecko.com/api/v3/global
 * JSON Response: {
 "data": {
   "active_cryptocurrencies": 9442,
   "upcoming_icos": 0,
   "ongoing_icos": 50,
   "ended_icos": 3375,
   "markets": 648,
   "total_market_cap": {
     "btc": 45944452.30485153,
     "eth": 672386313.4120709,
     "ltc": 13487839880.137497,
     "bch": 4009786074.286703,
     "bnb": 5687003729.005558,
     "eos": 515587181338.4248,
     "xrp": 2122700250080.3472,
     "xlm": 7330829649262.01,
     "link": 85024525501.83565,
     "dot": 71319046647.6792,
     "yfi": 66986639.09117442,
     "usd": 1910332780437.9521,
     "aed": 7017034369104.674,
     "ars": 188320605495573,
     "aud": 2640204074195.9766,
     "bdt": 163626279998026.78,
     "bhd": 720166803233.4003,
     "bmd": 1910332780437.9521,
     "brl": 10371769764831.752,
     "cad": 2424084306079.4688,
     "chf": 1775610381763.1262,
     "clp": 1533366812874129.5,
     "cny": 12342469061131.574,
     "czk": 41714408660199.195,
     "dkk": 12159971149950.78,
     "eur": 1635265873715.4727,
     "gbp": 1411470388487.1648,
     "hkd": 14870698979402.143,
     "huf": 588342814942375,
     "idr": 27348461095727050,
     "ils": 6132301948500.448,
     "inr": 141743826809325.34,
     "jpy": 213177855634631.97,
     "krw": 2266548380942749.5,
     "kwd": 575480108775.8131,
     "lkr": 381610271192650,
     "mmk": 3575357317699894,
     "mxn": 38840217475391.27,
     "myr": 8005249516425.234,
     "ngn": 786145059181734.8,
     "nok": 16542297472268.79,
     "nzd": 2751675812600.0938,
     "php": 97367373240251.17,
     "pkr": 325535982717872.2,
     "pln": 7580569167004.429,
     "rub": 139122850234564.5,
     "sar": 7165618142434.354,
     "sek": 16685836056725.322,
     "sgd": 2594826029329.4517,
     "thb": 64779384584650.75,
     "try": 16971975252243.215,
     "twd": 53095405322603.42,
     "uah": 50810446732257.64,
     "vef": 191281621305.25186,
     "vnd": 43485750506522390,
     "zar": 28891454608464.645,
     "xdr": 1349105664536.988,
     "xag": 84994411447.27872,
     "xau": 1100447198.1712794,
     "bits": 45944452304851.53,
     "sats": 4594445230485153
   },
   "total_volume": {
     "btc": 2781084.6966028297,
     "eth": 40700524.05952926,
     "ltc": 816438616.6144103,
     "bch": 242718198.355198,
     "bnb": 344242628.80135536,
     "eos": 31209243942.461113,
     "xrp": 128490141569.28102,
     "xlm": 443745808866.93945,
     "link": 5146658515.811777,
     "dot": 4317045894.727528,
     "yfi": 4054798.9475902426,
     "usd": 115635228946.53625,
     "aed": 424751322966.41626,
     "ars": 11399320869549.525,
     "aud": 159815402693.9945,
     "bdt": 9904537336633.129,
     "bhd": 43592746784.4099,
     "bmd": 115635228946.53625,
     "brl": 627818348519.428,
     "cad": 146733357972.8149,
     "chf": 107480285695.53967,
     "clp": 92816929218516.16,
     "cny": 747107650700.6768,
     "czk": 2525033986322.3545,
     "dkk": 736060786008.9563,
     "eur": 98985027965.7535,
     "gbp": 85438360894.66667,
     "hkd": 900145094449.9678,
     "huf": 35613248540557.55,
     "idr": 1655442231072867,
     "ils": 371197179384.4071,
     "inr": 8579960534989.567,
     "jpy": 12903966468601.875,
     "krw": 137197478697208.95,
     "kwd": 34834650179.22836,
     "lkr": 23099426199238.137,
     "mmk": 216421592212388.62,
     "mxn": 2351055002610.843,
     "myr": 484569426900.45996,
     "ngn": 47586506829887.3,
     "nok": 1001329388835.0568,
     "nzd": 166562949573.48294,
     "php": 5893789088400.657,
     "pkr": 19705167747415.664,
     "pln": 458862906059.04315,
     "rub": 8421309000874.922,
     "sar": 433745315438.6486,
     "sek": 1010017988667.6409,
     "sgd": 157068603465.5984,
     "thb": 3921190613577.032,
     "try": 1027338411435.3975,
     "twd": 3213942310659.0015,
     "uah": 3075630435139.902,
     "vef": 11578555474.416656,
     "vnd": 2632255891343114,
     "zar": 1748841878472.2732,
     "xdr": 81663333210.47809,
     "xag": 5144835668.175565,
     "xau": 66611673.63465204,
     "bits": 2781084696602.8296,
     "sats": 278108469660282.97
   },
   "market_cap_percentage": {
     "btc": 40.972420736968054,
     "eth": 17.503022431411903,
     "usdt": 3.61903882254022,
     "ada": 3.4282077571622924,
     "bnb": 2.7166562913022076,
     "xrp": 2.200384776047855,
     "sol": 2.107213044992036,
     "usdc": 1.6313746153689215,
     "dot": 1.4563509486991768,
     "doge": 1.3530505713540797
   },
   "market_cap_change_percentage_24h_usd": -2.3775623871173246,
   "updated_at": 1632880216
 }
}
 */


// MARK: - MarketDataResponse
struct MarketDataResponse: Codable {
    let data: MarketData
}

// MARK: - MarketData
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$\(item.value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$\(item.value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return "\(item.value.asPercentString())"
        }
        
        return ""
    }
}
