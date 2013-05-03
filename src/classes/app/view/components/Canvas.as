package app.view.components {
    
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import com.adobe.images.BitString;
	import com.adobe.images.JPGEncoder;
	import flash.utils.ByteArray;
	
	import app.ApplicationFacade;
    import app.model.*;
    import app.view.events.*;
    import app.view.components.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import flash.net.ObjectEncoding;
	import flash.net.NetStream;
	import flash.media.*;
	   
    import com.bumpslide.events.UIEvent;	
	import gs.TweenLite;
	
    /**
     * The main canvas view
     * 
     * @author Billy Bateman - White Label
     */
    public class Canvas extends MovieClip {
        
        static public var EVENT_CREATION_COMPLETE:String = "onCreationComplete";  		         
       	
		public var preloader_mc:MovieClip;
		
		public var webcam:Video = new Video(230, 172);
		public var camera:Camera;		
		
		public var video_snap:MovieClip;
		
		
		public var camFPS :   Number    = 15;
		public var camW   :   Number  	= 320;
		public var camH   :   Number 	 = 240;
		
			
        public function Canvas()
        {    
            trace("New Canvas Loaded");			
						
			//Framework Listener
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );		
        }	
		       
        private function onAddedToStage(event:Event):void
        {
        	trace('Canvas is initialized');
        	dispatchEvent( new UIEvent(EVENT_CREATION_COMPLETE, this ) ); 
        }
		
			
		public function setupWebcam():void{
			trace("Setup Webcam");
						
			camera = Camera.getCamera();
			camera.setMode(camW, camH, camFPS);
			camera.setQuality(244000, 85);
			camera.setKeyFrameInterval(60);
		
			resumeCamera();
			
			/* Use for testing when not running in browser
			freezeCamera();		
			*/
		}
		
		public function resumeCamera():void{
			trace("Start Camera");
			
			webcam.attachCamera(camera);			
			
			video_snap.addChild(webcam);
			
			preloader_mc.visible = false;			
			
		}		
		
		public function freezeCamera():void{
			
			trace("Freeze Camera");		
			
			var jpgSource:BitmapData = new BitmapData (video_snap.width, video_snap.height);
			jpgSource.draw(video_snap);
			
			webcam.attachCamera(null);
			preloader_mc.visible = true;
			
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
			
			dispatchEvent( new GenericEvent( ApplicationFacade.THUMBNAIL_CAPTURE, jpgStream ));			
			
		}		

		

        public function setSize(w:Number, h:Number):void
        {
                               
           // Set the size of the internal views components		   
            
        }	
		
		
		public function setObject(obj:*):void {
			  trace("Setting Object:" + obj);			 
        }		
		
    }
}
