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

		

		
	}
}
