package net.mg2013.utils
{

	public class MGStringUtils
	{
		public static function stringToIntVector(_value:String, _delimiter:String = ","):Vector.<int>
		{
			var vector:Vector.<int> = new Vector.<int>()
			var ar:Array = _value.split(_delimiter)
			for (var i:int = 0; i < ar.length; i++)
			{
				vector.push(int(ar[i]))
			}
			return vector
		}

		public static function combineAddressPaths(s1:String, s2:String):String
		{
			var str:String = ""
			if (s1.length - 1 == s1.lastIndexOf("/"))
			{
				str += s1.slice(0, s1.lastIndexOf("/"))
			}
			else
			{
				str += s1
			}
			str += "/"
			if (s2.indexOf("/") == 0)
			{
				str += s2.slice(1, s2.length)
			}
			else
			{
				str += s2
			}
			if (s1.length == 0)
			{
				if (s2.indexOf("/") == 0)
				{
					str = s2.slice(1, s2.length)
				}
				else
				{
					str = s2
				}
			}
			return str
		}

		public static function validateDutchZipcode(_zip:String):Boolean
		{
			var pattern:RegExp = /^[0-9]{4}\s?[A-Z]{2}$/;
			return _zip.toUpperCase().match(pattern) != null;
		}

		public static function validateDutchPhoneNumber(_phone:String):Boolean
		{
			var phone:String = _phone
			if (phone.indexOf("0031") == 0)
			{
				phone = phone.replace("0031", "0")
			}
			else if (phone.indexOf("+31") == 0)
			{
				phone = phone.replace("+31", "0")
			}
			if (phone.indexOf("(0)") > -1)
			{
				phone = phone.replace("(0)", "")
			}
			var pattern:RegExp = /^(\d{3}-?\d{7}|\d{4}-?\d{6})$/;
			return phone.match(pattern) != null;
		}
	}
}
