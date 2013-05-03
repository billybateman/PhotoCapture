package app.view {
    import app.ApplicationFacade;    

    import org.puremvc.interfaces.IMediator;    
    import app.Main;
    import app.view.components.*;
    
    import com.bumpslide.events.UIEvent;
    
    import app.model.StageProxy; 

    /**
     * A Mediator for interacting with the top level Application
     */
    public class ApplicationMediator extends BaseMediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "ApplicationMediator";
        
        /**
         * Constructor. 
         *  
         * @param object the viewComponent (root display object in this case)
         */
        public function ApplicationMediator( viewComponent:Object ) 
        {
           trace("Application Mediator Loaded");
		   
		   // pass the viewComponent to the superclass
            super( NAME, viewComponent );            
            
            // wait for gallery to be created
            viewComponent.addEventListener( Canvas.EVENT_CREATION_COMPLETE, registerChildMediators );
			
        }
        
        /**
         * Register addition mediators once child components have been initialized
         */
        private function registerChildMediators(event:UIEvent):void
        {
        	var canvas:Canvas = event.data as Canvas;
			
        				
        	// register child mediators            
            facade.registerMediator( new CanvasMediator( canvas ) );
            
            // trigger stage update
            sendNotification( ApplicationFacade.CMD_STAGE_UPDATE );
						
        }        
    }
}
