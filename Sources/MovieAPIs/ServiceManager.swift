//
//  ServiceManager.swift
//
//  Created by Jyoti on 22/01/18.
//

import UIKit

class ServiceManager:NSObject,URLSessionTaskDelegate {

    typealias responseBlock = (_ status :Bool, _ response :[String:Any]?, _ error:Error?) -> ()
    var completionHandler:responseBlock? = nil;
    
    static let shared = ServiceManager()
    private override init() {
        //init method
    }
    
    func makeHttpHandShakeRequest(request : URLRequest, callback : @escaping responseBlock) {
        
        let session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error{
                
                callback(false,nil,error)
            }
            else{
                                
                do {
                    
                    let response = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] ?? [:]
                    
                    print("response : \(response)")
                    callback(true,response,nil)

                }
                catch let error {
                    callback(true,nil,error)
                }
            }
            
            URLCache.shared.removeAllCachedResponses()

        })
        
        task.resume()
    }
    
    //MARK: - Delegate Method
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        
        // Set SSL policies for domain name check
        let policies:NSMutableArray? = NSMutableArray();
        policies?.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString)))
        SecTrustSetPolicies(serverTrust!, policies!);
        
        // Evaluate server certificate
        var result: SecTrustResultType = SecTrustResultType(rawValue: 0)!
        SecTrustEvaluate(serverTrust!, &result)
        let isServerTrusted:Bool = (result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed)
        
        
        
        // Get local and remote cert data
        /*let remoteCertificateData:NSData? = SecCertificateCopyData(certificate!)
        let pathToCert:String? = Bundle.main.path(forResource: "server", ofType: "cer")!
         
        
        let localCertificate:Data? = NSData(contentsOfFile: pathToCert!)! as Data
                
        if (isServerTrusted && (remoteCertificateData?.isEqual(to: localCertificate!))!) {
            
            print("CERTIFICATE MATCHES")
            let credential:URLCredential = URLCredential(trust: serverTrust!)
            completionHandler(.useCredential, credential)
        }
        else {
            
            print("CERTIFICATE DOES MATCHE")
            
            completionHandler(.cancelAuthenticationChallenge, nil)
        }*/
        
        
        let credential:URLCredential = URLCredential(trust: serverTrust!)
        completionHandler(.useCredential, credential)
    }
}
