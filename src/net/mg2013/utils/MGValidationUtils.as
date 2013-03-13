package net.mg2013.utils
{

	public class MGValidationUtils
	{
		public static function isNLPostcode(s : String) : Boolean
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
		}
	}
}