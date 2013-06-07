package net.mg2013.utils
{

	public class MGValidationUtils
	{
		/*public static function isNLPostcode(s : String) : Boolean
		{
			s = s.split(" ").join("")
			if (s.length == 6)
			{
				if (!isNaN(Number(s.substr(0, 4))) && isNaN(Number(s.substr(4, 1))) && isNaN(Number(s.substr(5, 1))))
				{
					return true
				}
			}
			return false
		}*/
		public static function isDutchZipcode(_zip:String):Boolean
		{
			var pattern:RegExp = /^[0-9]{4}\s?[A-Z]{2}$/;
			return _zip.toUpperCase().match(pattern) != null;
		}

		public static function isDutchPhoneNumber(_phone:String):Boolean
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

		public static function isDutchBankAccount(value:String):Boolean
		{
			value = value.split(".").join("").split(" ").join("");
			if (isNaN(Number(value)))
				return false;
			if (value.length > 1 && value.length < 8)
				return true;
			var start:int = 0;
			var end:int = 0;
			var digit:int;
			var digits:Array = value.split("");
			if (value.length == 9)
			{
				end = 9;
				for (var i:int = 0; i < 9; i++)
				{
					digit = digits[i] as int;
					if (!isNaN(digit))
					{
						start += digit * end;
						end--;
					}
					else
						return false;
				}
				trace("1", start/11);
				return start % 11 == 0;
			}
			if (value.length == 10)
			{
				for (var j:int = 0; j < 10; j++)
				{
					digit = digits[i] as int;
					if (!isNaN(digit))
					{
						start += digit * end;
						end++;
					}
					else
						return false;
				}
				trace("2");
				return start % 11 == 0;
			}
			return false;
		}
	}
}
