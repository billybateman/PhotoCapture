package app
{
    import flash.display.DisplayObject;
	
	import org.puremvc.interfaces.*;
    import org.puremvc.patterns.proxy.*;
    import org.puremvc.patterns.facade.*;
	import org.puremvc.patterns.observer.*;
	
    import app.view.*;
    import app.controller.*;     

    /**
     * A concrete <code>Facade</code> for the application.
     * <P>
     * The main job of the <code>ApplicationFacade</code> is to act as a single 
     * place for mediators, proxies and commands to access and communicate
     * with each other without having to interact with the Model, View, and
     * Controller classes directly. All this capability it inherits from 
     * the PureMVC Facade class.</P>
     * 
     * <P>
     * This concrete Facade subclass is also a central place to define 
     * notification constants which will be shared among commands, proxies and
     * mediators, as well as initializing the controller with Command to 
     * Notification mappings.</P>
     */
    public class ApplicationFacade extends Facade
    {
        
        // Notification name constants
        public static const CMD_STARTUP:String              = "cmdStartup";      
        public static const CMD_STAGE_UPDATE:String         = "cmdStageUpdate";        
        public static const STAGE_RESIZE:String             = "stageResize";
		public static const JAVASCRIPT_CALL:String          = "javascriptCall";
		public static const JAVASCRIPT_CMD:String           = "javascriptCMD";
		public static const THUMBNAIL_CREATE:String 		= "thumbnailCreate";
		public static const THUMBNAIL_CAPTURE:String		= "thumbnailCapture";
        public static const EVENT_CREATION_COMPLETE:String	= "onCreationComplete";
		public static const INIT_LOCALE:String				= "onInitLocaleProxy";
		
		// Flash Media Server
		public static const APP_READY:String 				= "appready";
		public static const NETSTATUS:String 				= "netstatus";
		public static const LOG:String 						= "log";
		
        /**
         * Startup method 
         */
        public function startup( root:DisplayObject, flashVars:Object ) : void {
            trace("Application Facade: Startup");
			notifyObservers( new Notification( ApplicationFacade.CMD_STARTUP, root ) );
			notifyObservers( new Notification( ApplicationFacade.INIT_LOCALE, flashVars ) );			
        }
                
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            trace("Application Facade: Initialize");			
			 
			super.initializeController();
			
			registerCommand( LOG, 				LogCommand );
			registerCommand( APP_READY, 		AppReadyCommand );
			registerCommand( JAVASCRIPT_CMD, 	JavaScriptCommand );
			registerCommand( THUMBNAIL_CREATE, 	ThumbnailCreateCommand );
			registerCommand( THUMBNAIL_CAPTURE, ThumbnailCaptureCommand );
			
            registerCommand( CMD_STARTUP,       StartupCommand      );           
            registerCommand( CMD_STAGE_UPDATE,  StageUpdateCommand  );
			registerCommand( INIT_LOCALE, InitLocaleProxyCommand );  
        }
        
        
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
        {
            trace("Application Facade: Get Instance");			
			
			if ( instance == null ){
				instance = new ApplicationFacade( );
		    }
            	
			return instance as ApplicationFacade;
			
			
        }
        
    }
}
