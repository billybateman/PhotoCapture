package app.controller
	{
		
		    
		import org.puremvc.interfaces.*;
		import org.puremvc.patterns.command.*;
		import org.puremvc.patterns.observer.*;
		
		import app.model.*;
		import app.view.ApplicationMediator;
		import app.ApplicationFacade;
		import app.Main;
		
		import flash.events.*;
		import flash.net.URLRequest;
		import flash.net.URLLoader;
		import flash.net.URLRequestHeader;
		import flash.net.URLRequestMethod;
	
		public class InitLocaleProxyCommand extends SimpleCommand implements ICommand
		{
			/* 
				When this runs we have initialised the framework and its players.
				Let's grab a proxy and connect to FMS.			
			 */
			override public function execute( note:INotification ):void
			{			
								 
				var locale:Object = note.getBody() as Object;
				
			    sendNotification( ApplicationFacade.LOG, "InitLocaleProxy Command: " + locale);
				
				facade.registerProxy( new LocaleProxy( LocaleProxy.NAME, locale ) );  
				
			}
		
		}
		
	}