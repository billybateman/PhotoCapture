package app.model {
    import org.puremvc.patterns.proxy.Proxy;
    import org.puremvc.interfaces.IProxy;
        
    import app.ApplicationFacade;
	
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import com.adobe.images.BitString;
	import com.adobe.images.JPGEncoder;
	import flash.utils.ByteArray;
    
    /**
     * Data Proxy
     * 
     * @author Billy Bateman
	 *
     */
    public class ServiceProxy extends Proxy implements IProxy {
        
        // proxy name
        public static const NAME:String = "ServiceProxy";       
        
       
		public var guid:String = "";
		public var serviceUrl:String = "";
		public var destination:String = "";
		 
        public function ServiceProxy()
        {
            super(NAME);            
        }
		
		public function setGUID(guidIn:String):void{
			guid = guidIn;
			destination = guid + ".jpg";
		}		
		
		public function setServiceUrl(serviceUrlIn:String):void{
			serviceUrl = serviceUrlIn;
		}		
		
		public function thumbnailCapture(jpgStream:ByteArray):void {
			trace("Service Proxy: thumbnailCapture");		
		
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var jpgURLRequest:URLRequest = new URLRequest(serviceUrl + "" + destination);
			jpgURLRequest.requestHeaders.push(header);
			jpgURLRequest.method = URLRequestMethod.POST;			
			jpgURLRequest.data = jpgStream;
			
			// Load URLREQUEST into URLLOADER		
			var loader:URLLoader = new URLLoader();
            configureListeners_capture(loader);

            try {
                loader.load(jpgURLRequest);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
        }		
		

        private function configureListeners_capture(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler_capture);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }		
		

        private function completeHandler_capture(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            trace("completeHandler_capture: " + loader.data);
    
            //var vars:URLVariables = new URLVariables(loader.data);
            //trace("The answer is " + vars.answer);			
			sendNotification( ApplicationFacade.THUMBNAIL_CREATE, loader.data );
			sendNotification( ApplicationFacade.JAVASCRIPT_CMD, loader.data );
        }     		
		
		
		private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
			
    }
}
