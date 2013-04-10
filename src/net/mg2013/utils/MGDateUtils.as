package net.mg2013.utils
{
    
    /////////////////////////////////////////////////////////////////////////
    public class MGDateUtils
    {
        ////////////////////////       PUBLIC VARS                                    /////////////////////////////////////////////////
        //
        public static const DAY_IN_MILLISECONDS:Number = 1000 * 60 * 60 * 24;
        
        public static const WEEK_IN_MILLISECONDS:Number = DAY_IN_MILLISECONDS * 7;
        
        public static const DAYS_OF_THE_WEEK_NL:Array = [ "ZO", "MA", "DI", "WO", "DO", "VR", "ZA", "ZO" ];
        
        public static const DAYS_OF_THE_WEEK_ENG_FULL:Array = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
        
        public static const DAYS_OF_THE_WEEK_ENG_SHORT:Array = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
        
        public static const MONTHS_OF_THE_YEAR_NL:Array = [ "Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli", "Augustus", "September", "Oktober", "November", "December" ];
        
        public static const MONTHS_OF_THE_YEAR_NL_SHORT:Array = [ "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec" ];
        
        public static const MONTHS_OF_THE_YEAR_ENG:Array = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
        
        //
        ////////////////////////       PUBLIC FUNCTIONS                       /////////////////////////////////////////////////
        //
        public static function ageValidation(date:Date, ageLimit:int):Boolean
        {
            var today:Date = new Date();
            var diff:Date = new Date();
            diff.setTime(today.getTime() - date.getTime());
            var userAge:int = diff.getFullYear() - 1970;
            if (userAge >= ageLimit)
                return true;
            else
                return false;
        }
        
        public static function getWeekArray(d:Date, w:Number = 1):Array
        {
            var ar:Array = new Array();
            var dn:Number = d.day == 0 ? d.day + 6 : d.day - 1;
            for (var i:uint = 0; i < 7 * w; i++)
            {
                var n:Number = (i * MGDateUtils.DAY_IN_MILLISECONDS) - (dn * MGDateUtils.DAY_IN_MILLISECONDS);
                var newD:Date = new Date(d.valueOf() + n);
                ar.push(newD);
            }
            return ar;
        }
        
        public static function getMonthArray(d:Date):Array
        {
            var ar:Array = new Array();
            var L:Number = 6;
            for (var i:uint = 0; i < L; i++)
            {
                var newA:Array = MGDateUtils.getWeekArray(new Date(d.valueOf() + (i * MGDateUtils.WEEK_IN_MILLISECONDS)));
                ar = ar.concat(newA);
            }
            return ar;
        }
        
        public static function getWeekNumber(d:Date):Number
        {
            var Y:Number = d.getFullYear();
            var M:Number = d.getMonth();
            var D:Number = d.getDate();
            var isLeapYear:Boolean = (Y % 4 == 0 && Y % 100 != 0) || Y % 400 == 0;
            var lastYear:Number = Y - 1;
            var lastYearIsLeap:Boolean = (lastYear % 4 == 0 && lastYear % 100 != 0) || lastYear % 400 == 0;
            var month:Array = [ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 ];
            var DayOfYearNumber:Number = D + month[M];
            if (isLeapYear && M > 1)
                DayOfYearNumber++;
            var YY:Number = (Y - 1) % 100;
            var C:Number = (Y - 1) - YY;
            var G:Number = YY + YY / 4;
            var Jan1Weekday:Number = Math.floor(1 + (((((C / 100) % 4) * 5) + G) % 7));
            var H:Number = DayOfYearNumber + (Jan1Weekday - 1);
            var Weekday:Number = Math.floor(1 + ((H - 1) % 7));
            var YearNumber:Number = Y;
            var WeekNumber:Number;
            if (DayOfYearNumber <= (8 - Jan1Weekday) && Jan1Weekday > 4)
            {
                YearNumber = Y - 1;
                if (Jan1Weekday == 5 || (Jan1Weekday == 6 && isLeapYear))
                {
                    WeekNumber = 53;
                }
                else
                {
                    WeekNumber = 52;
                }
            }
            if (YearNumber == Y)
            {
                var I:Number = 365;
                if (isLeapYear)
                {
                    I = 366;
                }
                if (I - DayOfYearNumber < 4 - Weekday)
                {
                    YearNumber = Y + 1;
                    WeekNumber = 1;
                }
            }
            if (YearNumber == Y)
            {
                var J:Number = DayOfYearNumber + (7 - Weekday) + (Jan1Weekday - 1);
                WeekNumber = J / 7;
                if (Jan1Weekday > 4)
                {
                    WeekNumber--;
                }
            }
            return WeekNumber;
        }
        
        public static function numberAdditiveENG(_num:Number):String
        {
            var str:String = _num.toString();
            var last:String = str.substr(-1, 1);
            if (last == "1")
            {
                str += "st";
            }
            else if (last == "2")
            {
                str += "nd";
            }
            else if (last == "3")
            {
                str += "rd";
            }
            else
            {
                str += "th";
            }
            return str;
        }
    }
}
