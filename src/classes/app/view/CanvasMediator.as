package app.view {

    import org.puremvc.interfaces.IMediator;
    import org.puremvc.interfaces.INotification;
    
       
    import app.ApplicationFacade;    
	import app.model.*;
    import app.view.events.*;
    import app.view.components.*;
    
    import com.bumpslide.events.UIEvent;
	
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.NetStream;
	import flash.media.*;
	import flash.media.Camera;
    import flash.media.Video;
	
    /**
     * Mediator for Canvas
     * 
     * @author Billy Bateman
     */
    public class CanvasMediator extends BaseMediator implements IMediator {
        
       public static const NAME:String = "CanvasMediator";
       
	   public var nc:NetConnection = new NetConnection;
	   
        public function CanvasMediator(viewComponent:Object = null)
        {
            
			trace("Canvas Mediator Loaded");
			
			super(NAME, viewComponent);
            
            // listen for UI events from our view
            canvas.addEventListener( ApplicationFacade.THUMBNAIL_CAPTURE, onThumbnailCapture );	
			
			connectUI();
        }
		
		
		/* Javascript Notification */
		private function onThumbnailCapture( e:GenericEvent ):void
		{
			trace("Canvas Mediator: onThumbnailCapture");
			sendNotification( ApplicationFacade.THUMBNAIL_CAPTURE, e.data );
		}
		
		private function connectUI(){
			trace("Connect UI");			
			showCamera();			
		}
		
		public function showCamera(){
			canvas.setupWebcam();
		}			
        
        /**
         * viewComponent cast to appropriate type
         */
        public function get canvas() : Canvas {
            return viewComponent as Canvas;
        }
        
        /**
         * List all notifications this Mediator is interested in.
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [
               
                ApplicationFacade.STAGE_RESIZE,
				ApplicationFacade.JAVASCRIPT_CALL,
				ApplicationFacade.THUMBNAIL_CREATE
            ];            
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) 
            {
               
                case ApplicationFacade.STAGE_RESIZE:
                    	trace("Canvas Mediator: Resize");
						var stage:StageProxy = note.getBody() as StageProxy;
                    	canvas.setSize( stage.stageWidth, stage.stageHeight );					
                    break;
				case ApplicationFacade.JAVASCRIPT_CALL:
						trace("Canvas Mediator: Javascript Call");
						canvas.freezeCamera();
                    break;				
				case ApplicationFacade.THUMBNAIL_CREATE:
						trace("Canvas Mediator: THUMBNAIL_CREATE");
						canvas.resumeCamera();
                    break;				
                
                default:
                    break;
            }
        }       
        
    }
}
