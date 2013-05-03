package app.controller
	{
		
		import flash.display.DisplayObject;
		import flash.display.BitmapData;
		import flash.geom.Rectangle;
		import flash.geom.ColorTransform;
		import flash.geom.Matrix;
		import com.adobe.images.BitString;
		import com.adobe.images.JPGEncoder;
		import flash.utils.ByteArray;
    
		import org.puremvc.interfaces.*;
		import org.puremvc.patterns.command.*;
		import org.puremvc.patterns.observer.*;
		
		import app.model.*;
		import app.view.ApplicationMediator;
		import app.ApplicationFacade;
		import app.Main;
		
		
	
		public class ThumbnailCaptureCommand extends SimpleCommand implements ICommand
		{
			/* 
				When this runs we have initialised the framework and its players.
				Let's grab a proxy and connect to FMS.			
			 */
			override public function execute( note:INotification ):void
			{			
				// send something to the trace window
				sendNotification( ApplicationFacade.LOG, "Thumbnail Capture Command: Execute");
				
				// Get data from note
				var jpgStream : ByteArray = note.getBody() as ByteArray;
				
				// Get GUID from localproxy
				var localProxy:LocaleProxy = facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;
         		var flashVars:Object = localProxy.getLocale() as Object;				
								
				// Get Service Proxy and Run thumbnailCapture function on proxy object
				var svcProxy:ServiceProxy = facade.retrieveProxy( ServiceProxy.NAME ) as ServiceProxy;
         		
				// set guid in service proxy
				if(flashVars.guid){
					sendNotification( ApplicationFacade.LOG, "GUID:" + flashVars.guid);
					svcProxy.setGUID(flashVars.guid);
				} else {
					svcProxy.setGUID(generateRandomString(16));
				}
				
				if(flashVars.serviceUrl){
					sendNotification( ApplicationFacade.LOG, "serviceUrl:" + flashVars.serviceUrl);
					svcProxy.setServiceUrl(flashVars.serviceUrl);
				} else {
					svcProxy.setServiceUrl("http://localhost/whitenet/phpPortal/index.php/services/photoCapture/");
					
				}
				
				svcProxy.thumbnailCapture(jpgStream);
				
				
			}
			
			 public function generateRandomString(newLength:uint = 1, userAlphabet:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):String{
			  var alphabet:Array = userAlphabet.split("");
			  var alphabetLength:int = alphabet.length;
			  var randomLetters:String = "";
			  for (var i:uint = 0; i < newLength; i++){
				randomLetters += alphabet[int(Math.floor(Math.random() * alphabetLength))];
			  }
			  return randomLetters;
			}
		
		}
		
	}