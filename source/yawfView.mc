import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.Time.Gregorian;


class yawfView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        //Date
        var nowInfo = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        
        var nowInfo_short = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var CHN_Date = LunarDateUtils.getLunarDate(nowInfo_short.year, nowInfo_short.month, nowInfo_short.day);
		
        var nowString = Lang.format("$1$-$2$ $3$", [nowInfo.day, nowInfo.month, CHN_Date]);
		var dateLabel = View.findDrawableById("DateLabel");
		dateLabel.setText(nowString);

        //HR
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        // Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        // Sensor.enableSensorEvents(method(:onSensor));
        // var sensorInfo = Sensor.getInfo();
		if (heartRate == null) {
            heartRate = 0;
        }
    	
        var batteryLevel = System.getSystemStats().battery.toNumber();
        
        var HRString = Lang.format("$1$  $2$%", [heartRate, batteryLevel]);
		var HRLabel = View.findDrawableById("HRLabel");
		HRLabel.setText(HRString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
