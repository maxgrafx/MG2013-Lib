package net.mg2013.singeltons
{
	import flash.events.EventDispatcher;

	public class ObjectPools
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private static var instance:ObjectPools;

		private var __poolTypes:Vector.<Class> = new Vector.<Class>();

		private var __poolResetFunctions:Vector.<Function> = new Vector.<Function>();

		private var __poolFactoryFunctions:Vector.<Function> = new Vector.<Function>();

		private var __pools:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();

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

		/**
		 *
		 * @param classObject
		 * @param resetFunction, resetFunction(object:[classObject]) will recieve a instance of the "classObject" and reset it to it's default values.
		 * @param factoryFunction, factoryFunction():[classObject] will return a instance of the "classObject" and will instantiate it to put in the pool.
		 * @param poolSize
		 *
		 */
		public function createPool(classObject:Class, resetFunction:Function, factoryFunction:Function = null, poolSize:int = 10):void
		{
			if (__poolTypes.indexOf(classObject) >= 0)
				return;
			__poolTypes.push(classObject);
			__poolResetFunctions.push(resetFunction);
			__poolFactoryFunctions.push(factoryFunction);
			var vector:Vector.<Object> = new Vector.<Object>();
			var used:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < poolSize; i++)
			{
				var obj:Object;
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

		/**
		 *
		 * @param classObject, get a instance of a specific type of Class.
		 * @param resetFunction, give a different reset function to the Class that will be returned, which will overwrite the default reset function.
		 * @return
		 *
		 */
		public function getObject(classObject:Class, resetFunction:Function = null):*
		{
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
