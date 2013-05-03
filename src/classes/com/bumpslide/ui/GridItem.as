package com.bumpslide.ui {    import flash.events.TimerEvent;        import flash.display.MovieClip;        import com.bumpslide.util.IGridItem;    import flash.utils.Timer;        /**     * Basic Grid Item including invalidation/update hook and buttonMode init     *      * Use this as a base class for cell renderers in GridLayout grids.       * Or, you can make your own class that implements IGridItem.     *      * @author David Knape     */    public class GridItem extends MovieClip implements IGridItem {                private var _gridIndex:Number;        private var _gridItemData:*;                protected var _updateTimer:Timer;        protected var _updateDelay:int=100;                public function GridItem() {        	super();        	init();        }                /**         * Override this to add any necessary tear-down logic, but be sure to call super.destroy()         */        public function destroy():void        {        	_updateTimer.reset();        }                /**         * Override in subclass to update view         */        protected function update():void        {        	trace( '[GridItemData.update] You should override the update method for '+ this );          	        }                        /**         * Init timer for updates, and assume we are a button         */        protected function init() : void {        	        	// usually these are buttons...        	stop();        	buttonMode = true;            mouseChildren = false;            cacheAsBitmap = true;                                    // create timer for delayed updates            _updateTimer = new Timer( _updateDelay, 1 );            _updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, doUpdate);        }                /**         * Triggers update after a slight delay         */        protected function invalidate():void {        	_updateTimer.reset();        	_updateTimer.start();        }                /**         * Calls update hook         */        private function doUpdate(event:TimerEvent=null):void        {        	_updateTimer.reset();        	update();        }                //------------------------------------        // IGridItem Interface implementation        //------------------------------------                /**         * grid index         */ 		public function get gridIndex():int {        	return _gridIndex;        }                /**         * grid dataprovider data for this grid index         */        public function get gridItemData():* {        	return _gridItemData;        }                /**         * sets grid index (used by GridLayout)         */        public function set gridIndex(n:int):void {        	_gridIndex = n;        	//invalidate();        }                /**         * Updates data (used by GridLayout)         *          * This is where we call invalidate to trigger an update process         */        public function set gridItemData(d:*):void {        	_gridItemData = d;			invalidate();        }            }}