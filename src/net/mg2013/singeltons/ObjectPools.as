package net.mg2013.singeltons
{
	import flash.utils.describeType;
	
	import net.mg2013.display.mg_internal;
	import net.mg2013.interfaces.IPoolable;

	use namespace mg_internal

	public class ObjectPools
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private static var instance:ObjectPools;

		private var __poolTypes:Vector.<Class> = new Vector.<Class>();

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
		 * <h1>hasPoolingCapabilities</h1>
		 * <p>To determine of the class has the capability to implement a pool</p>
		 * <ul>
		 * 		<li>@param classObject</li>
		 * 		<li>@return true if it's capable</li>
		 * </ul>
		 *
		 */
		mg_internal static function hasPoolingCapabilities(classObject:Class):Boolean
		{
			var typeXML:XML = describeType(classObject);
			if (String(typeXML.factory.implementsInterface).indexOf("IPoolable") < 0)
			{
				return false
			}
			return true;
		}

		/**
		 *
		 * @param classObject implementing
		 * @param resetFunction, resetFunction(object:[classObject]) will recieve a instance of the "classObject" and reset it to it's default values.
		 * @param factoryFunction, factoryFunction():[classObject] will return a instance of the "classObject" and will instantiate it to put in the pool.
		 *
		 */
		public function createPool(classObject:Class, factory:Function = null):void
		{
			var typeXML:XML = describeType(classObject);
			if (hasPoolingCapabilities(classObject))
			{
				throw new Error(typeXML.@name + " class doesn't implement net.mg2013.interfaces.IPoolable");
			}
			if (hasPool(classObject))
				return;
			__poolTypes.push(classObject);
			__poolFactoryFunctions.push(factory);
			var vector:Vector.<Object> = new Vector.<Object>();
			var used:Vector.<int> = new Vector.<int>();

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
		public function getObject(classObject:Class, args:Array=null):IPoolable
		{
			var index:int = __poolTypes.indexOf(classObject);
			if (index == -1)
				throw new Error("There is no pool for class " + classObject);
			var index2:int = __used[index].indexOf(0);
			if (index2 >= 0)
			{
				__used[index][index2] = 1;
				return __pools[index][index2] as IPoolable;
			}
			else
			{
				var obj:*;
				if (__poolFactoryFunctions[index] != null)
				{
					obj = __poolFactoryFunctions[index](args);
				}
				else
					obj = new classObject();
				__pools[index].push(obj);
				__used[index].push(1);
				//IPoolable(obj).reset(
				/*if (resetFunction != null)
					resetFunction(obj);
				else
					__poolResetFunctions[index](obj);*/
				return obj as IPoolable;
			}
			return null;
		}

		public function returnObject(classObject:Class, obj:IPoolable):void
		{
			var index:int = __poolTypes.indexOf(classObject);
			if (index == -1)
				return;
			var index2:int = __pools[index].indexOf(obj);
			if (index2 == -1)
				return;
			__used[index][index2] = 0;
		}

		public function hasPool(classObject:Class):Boolean
		{
			var index:int = __poolTypes.indexOf(classObject);
			if (index >= 0)
				return true
			return false;
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
