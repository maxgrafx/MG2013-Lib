package net.mg2013.display.textfield
{
	import flash.text.TextField;

	public class MGInputTextFieldType
	{
		public static const ALL:String = "all";

		public static const TEXT:String = "text";

		public static const TEXT_NUMBERS:String = "text_numbers";

		public static const TELEPHONE:String = "telephone";

		public static const EMAIL:String = "email";

		public static const POSTCODE:String = "postcode";

		public static const NUMBERS:String = "numbers";

		public static const NOSPACES:String = "nospaces";

		//§©«®°²³µ¹º»¼½¾ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÒÓÔÕÖ×ØÙÚÛÜÝßàáâäãåæçèêéëìíîïðñòóôõöøùúûüýþÿAaAaAaCcCcCcCcDddeEEeEeEeEeGgGgGgGgHhSsSsš€™£
		/**A-Z**/
		public static const ATOZ_STRING_CAPITALS:String = "A-Z";

		/**ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÒÓÔÕÖ×ØÙÚÛÜÝ**/
		public static const ATOZ_EXTRA_STRING_CAPITALS:String = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÒÓÔÕÖ×ØÙÚÛÜÝ";

		public static const ATOZ_STRING:String = "a-z";

		/**àáâäãåæçèêéëìíîïðñòóôõöøùúûüýþÿ**/
		public static const ATOZ_EXTRA_STRING:String = "àáâäãåæçèêéëìíîïðñòóôõöøùúûüýþÿ";

		/****/
		public static const SPACE_STRING:String = " ";

		/**^ **/
		public static const NO_SPACE_STRING:String = "^ ";

		/**0-9\\(\\)\\+**/
		public static const TELEPHONE_STRING:String = "0-9\\(\\)\\+";

		/**a-zA-Z0-9@\\.\\-\\_**/
		public static const EMAIL_STRING:String = "a-zA-Z0-9@\\.\\-\\_";

		/**0-9**/
		public static const NUMBER_STRING:String = "0-9";

		/**§©«®°²³µ¹º»¼½¾×ßš€™£**/
		public static const ODD_CHARACTERS_STRING:String = "§©«®°²³µ¹º»¼½¾×ßš€™£";

		public static function setRestriction(_field:TextField, _fieldType:String = ALL):void
		{
			switch (_fieldType)
			{
				case TEXT:
					//_field.restrict = "a-zA-Z äëüïöáàéèíìóòúùçÄËÜÏÖÁÀÉÈÍÌÓÒÚÙÇ";
					_field.restrict = ATOZ_STRING + ATOZ_EXTRA_STRING + ATOZ_STRING_CAPITALS + ATOZ_EXTRA_STRING_CAPITALS + SPACE_STRING;
					break;
				case TEXT_NUMBERS:
					_field.restrict = ATOZ_STRING + ATOZ_EXTRA_STRING + ATOZ_STRING_CAPITALS + ATOZ_EXTRA_STRING_CAPITALS + NUMBER_STRING + SPACE_STRING;
					break;
				case TELEPHONE:
					_field.restrict = TELEPHONE_STRING;
					break;
				case EMAIL:
					_field.restrict = EMAIL_STRING;
					break;
				case POSTCODE:
					_field.restrict = ATOZ_STRING + ATOZ_STRING_CAPITALS + NUMBER_STRING + SPACE_STRING;
					//_field.restrict = "a-zA-Z0-9 ";
					_field.maxChars = 7;
					break;
				case NUMBERS:
					_field.restrict = NUMBER_STRING + SPACE_STRING;
					break;
				case NOSPACES:
					_field.restrict = NO_SPACE_STRING;
					break;
			}
		}
	}
}
