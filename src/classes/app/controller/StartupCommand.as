package app.controller {
    
    import flash.display.DisplayObject;
    
    import org.puremvc.interfaces.*;
    import org.puremvc.patterns.command.*;
    import org.puremvc.patterns.observer.*;
    
    import app.model.*;
    import app.view.ApplicationMediator;
    import app.ApplicationFacade;
    import app.Main;
	

    /**
     * Create and register proxies and mediators
     */
    public class StartupCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
        {  
            sendNotification( ApplicationFacade.LOG, "Startup Command: Execute" );
		    
            // body of notification is our Main movieclip
            var root:Main = (note.getBody() as Main);
            
        
            // register proxies
            //-------------------
            
            // proxy to stage data
            facade.registerProxy( new StageProxy( root.stage ) );
            
            // view state proxy (manages application view state)
            facade.registerProxy( new StateProxy() );
			
			 // service proxy (manages application web services)
            facade.registerProxy( new ServiceProxy() );   
			      
            // proxy to our javascript commands in/out
            facade.registerProxy( new JavascriptProxy() );
			
			// proxy to our net stream
            facade.registerProxy( new NetStreamProxy() );
			
            // register top-level mediator
            //-----------------------------
            
            facade.registerMediator( new ApplicationMediator( root ) );    
            
			sendNotification( ApplicationFacade.APP_READY, root );
            
        }
    }
}