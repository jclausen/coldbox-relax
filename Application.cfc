﻿/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
*/
component{
	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.setClientCookies = true;

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";

	this.mappings[ "/coldbox" ] = COLDBOX_APP_ROOT_PATH & "coldbox";
	this.mappings[ "/testbox" ] = COLDBOX_APP_ROOT_PATH & "testbox";
	//overrides needed to ensure tests perform across all platforms
	this.mappings[ "/modules" ] = COLDBOX_APP_ROOT_PATH & "modules";
	this.mappings[ "/relax" ] = COLDBOX_APP_ROOT_PATH & "modules/relax";
	this.mappings[ "/tests" ] = COLDBOX_APP_ROOT_PATH & "tests";
	this.mappings[ "/root" ]   = COLDBOX_APP_ROOT_PATH;
	
	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// request start
	public boolean function onRequestStart(String targetPage){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}

}