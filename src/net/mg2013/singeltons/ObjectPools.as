package net.mg2013.singeltons
{
	import flash.events.EventDispatcher;

	public class ObjectPools extends EventDispatcher
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private static var instance:ObjectPools;

		private var __poolTypes:Vector.<Class> = new Vector.<Class>();

		private var __poolResetFunctions:Vector.<Function> = new Vector.<Function>();

		private var __poolFactoryFunctions:Vector.<Function> = new Vector.<Function>();

		private var __pools:Vector.<Vector.<*>> = new Vector.<Vector.<*>>();

		private var __used:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();

		public function ObjectPools(pvt:SingletonEnforcer)
		{
			super();
			if (!pvt)
				throw new Error("Class is singleton, use getInstance");
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public static function getInstance():ObjectPools
		{
			if (instance == null)
				instance = new ObjectPools(new SingletonEnforcer());
			return instance;
		}

		//public function createPool(classObject:Class, poolSize:int = 10, ... args):void
		public function createPool(classObject:Class, resetFunction:Function, factoryFunction:Function = null, poolSize:int = 10):void
		{
			if (__poolTypes.indexOf(classObject) >= 0)
				return;
			__poolTypes.push(classObject);
			__poolResetFunctions.push(resetFunction);
			__poolFactoryFunctions.push(factoryFunction);
			var vector:Vector.<*> = new Vector.<*>();
			var used:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < poolSize; i++)
			{
				//var obj:* = applyToClass(classObject, args);
				var obj:*;
				if (factoryFunction != null)
					obj = factoryFunction();
				else
					obj = new classObject();
				vector.push(obj);
				used.push(0);
			}
			__pools.push(vector);
			__used.push(used);
		}

		public function getObject(classObject:Class, resetFunction:Function=null):*
		{
			trace(classObject);
			var index:int = __poolTypes.indexOf(classObject);
			if (index == -1)
				throw new Error("There is no pool for class " + classObject);
			var index2:int = __used[index].indexOf(0);
			if (index2 >= 0)
			{
				__used[index][index2] = 1;
				if (resetFunction != null)
					resetFunction(__pools[index][index2]);
				else
					__poolResetFunctions[index](__pools[index][index2]);
				return __pools[index][index2];
			}
			else
			{
				var obj:*;
				if (__poolFactoryFunctions[index] != null)
					obj = __poolFactoryFunctions[index]();
				else
					obj = new classObject();
				__pools[index].push(obj);
				__used[index].push(1);
				if (resetFunction != null)
					resetFunction(obj);
				else
					__poolResetFunctions[index](obj);
				return obj;
			}
			return null;
		}

		public function returnObject(classObject:Class, obj:*):void
		{
			var index:int = __poolTypes.indexOf(classObject);
			if (index == -1)
				return;
			var index2:int = __pools[index].indexOf(obj);
			if (index2 == -1)
				return;
			__used[index][index2] = 0;
		}
		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
	/*protected function applyToClass(classObject:Class, args:Array):*
	{
		switch (args.length)
		{
			case 0:
				return new classObject();
				break;
			case 1:
				return new classObject(args[0]);
				break;
			case 2:
				return new classObject(args[0], args[1]);
				break;
			case 3:
				return new classObject(args[0], args[1], args[2]);
				break;
			case 4:
				return new classObject(args[0], args[1], args[2], args[3]);
				break;
			case 5:
				return new classObject(args[0], args[1], args[2], args[3], args[4]);
				break;
			case 6:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5]);
				break;
			case 7:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				break;
			case 8:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
				break;
			case 9:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
				break;
			case 10:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
				break;
			case 11:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);
				break;
			case 12:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]);
				break;
			case 13:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12]);
				break;
			case 14:
				return new classObject(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13]);
				break;
			default:
				throw new Error("more than 14 arguments: " + args.length);
				break;
		}
		return null;
	}*/
		//////////////
		////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
		//////////////
		//////////////
		////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE MOUSE EVENTS --------------------------------------------------------------------------------- OVERRIDE MOUSE EVENTS ////////////
		//////////////
		//////////////
		////////////// EVENTS ------------------------------------------------------------------------------------------------ EVENTS ///////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE EVENTS --------------------------------------------------------------------------------------- OVERRIDE EVENTS //////////////////
		//////////////
		//////////////
		////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}

internal class SingletonEnforcer
{
}
