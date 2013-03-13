package net.mg2013.utils
{

	public class MGVectorUtil
	{
		////////// CONSTRUCTOR -------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public static function removeDuplicates(tarArray:*):*
		{
			tarArray = tarArray as Vector.<*>;
			return tarArray.filter(MGVectorUtil._removeDuplicatesFilter);
		}

		protected static function _removeDuplicatesFilter(e:*, i:int, tarArray:*):Boolean
		{
			tarArray = tarArray as Vector.<*>;
			return (i == 0) ? true : tarArray.lastIndexOf(e, i - 1) == -1;
		}

		public static function removeItem(tarArray:*, item:*):uint
		{
			tarArray = tarArray as Vector.<*>
			var i:int = tarArray.indexOf(item);
			var f:uint = 0;
			while (i != -1)
			{
				tarArray.splice(i, 1);
				i = tarArray.indexOf(item, i);
				f++;
			}
			return f;
		}

		public static function removeItems(tarArray:*, items:*):Boolean
		{
			var removed:Boolean = false;
			tarArray = tarArray as Vector.<*>
			var l:uint = tarArray.length;
			while (l--)
			{
				if (items.indexOf(tarArray[l]) > -1)
				{
					tarArray.splice(l, 1);
					removed = true;
				}
			}
			return removed;
		}

		public static function addItemsAt(tarArray:*, items:*, index:int = 0x7FFFFFFF):Boolean
		{
			tarArray = tarArray as Vector.<*>;
			items = items as Vector.<*>;
			if (items.length == 0)
				return false;
			/*var args:Vector.<*> = items.concat();
			args.splice(0, 0, index, 0);
			tarArray.splice.apply(null, args);*/
			var n:int = items.length;
			for (var i:int = 0; i < n; i++)
			{
				tarArray.splice(index, 0, items[i]);
				index++;
			}
			return true;
		}
		////////// PUBLIC FUNCTIONS --------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		////////// OVERRIDE PUBLIC FUNCTIONS ------------------------------------------------------------------------------------------------------------ OVERRIDE PUBLIC FUNCTIONS
		////////// PUBLIC STATIC FUNCTIONS -------------------------------------------------------------------------------------------------------------- PUBLIC STATIC FUNCTIONS
		////////// PROTECTED FUNCTIONS ------------------------------------------------------------------------------------------------------------------ PROTECTED FUNCTIONS
		////////// OVERRIDE PROTECTED FUNCTIONS --------------------------------------------------------------------------------------------------------- OVERRIDE PROTECTED FUNCTIONS
		////////// EVENT FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		////////// OVERRIDE EVENT FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE EVENT FUNCTIONS
		////////// MOUSE FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		////////// OVERRIDE MOUSE FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE MOUSE FUNCTIONS
		////////// PROTECTED GET & SET FUNCTIONS -------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		////////// PUBLIC GET & SET FUNCTIONS ----------------------------------------------------------------------------------------------------------- PUBLIC GET & SET FUNCTIONS
	}
}
