package app.model {	
	
	import org.puremvc.patterns.observer.Notification;
    import org.puremvc.patterns.proxy.Proxy;
    import org.puremvc.interfaces.IProxy;

    import flash.external.ExternalInterface;
	import flash.events.Event;
    import flash.events.TimerEvent;

    import app.ApplicationFacade;
    
    /**
     * @author Billy Bateman
     */
    public class JavascriptProxy extends Proxy implements IProxy {
        
        public static const NAME : String = "JavascriptProxy";
                                
        public function JavascriptProxy() 
        {
            super(NAME);			
			init();            
        }
        
		public function init() : void  {			
			ExternalInterface.addCallback("capturePhoto", callFromJavaScript);						
        }
		
		public function callFromJavaScript(theObject:uint){			
			facade.notifyObservers( new Notification( ApplicationFacade.JAVASCRIPT_CALL, theObject ) );
		}
		
		public function callJavaScript(theObject:String){			
			// Call External Interface
			trace("Calling Javascript");
		}
    }
}
