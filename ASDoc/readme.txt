ASDoc won't compile now because of Flex compiler errors:
========================================================


C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\ASDoc>"C:\Program Files\Adobe\Flex\sdk\bin\asdoc.exe" -doc-sources "C:\_io\interacti\games\The-Ledge\development\src\The-Ledge" -main-title "TL ASDoc" -output "C:\Documents and Settings\Pup\Desktop" 
Loading configuration file C:\Program Files\Adobe\Flex\sdk\frameworks\flex-config.xml
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(19): col: 15 Error: A conflict exists with inherited definition Engine:Prop.rootDisplay in namespace public.
		private var rootDisplay:MovieClip;
		            ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(38): col: 20 Error: Incompatible override.
		private function errorDisplay(arg:*):void
		                 ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(38): col: 20 Error: Overriding a function that is not marked for override.
		private function errorDisplay(arg:*):void
		                 ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(47): col: 19 Error: Incompatible override.
		public function printInfo():void
		                ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(47): col: 19 Error: Overriding a function that is not marked for override.
		public function printInfo():void
		                ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(56): col: 23 Error: Overriding a function that is not marked for override.
		public function get bottomY():Number
		                    ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(61): col: 23 Error: Overriding a function that is not marked for override.
		public function get topY():Number
		                    ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(66): col: 23 Error: Overriding a function that is not marked for override.
		public function get leftX():Number
		                    ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(71): col: 23 Error: Overriding a function that is not marked for override.
		public function get rightX():Number
		                    ^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(49): col: 4 Error: Ambiguous reference to errorDisplay.
			errorDisplay("--------------------------------");
			^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(50): col: 4 Error: Ambiguous reference to errorDisplay.
			errorDisplay("Trigger Event Information");
			^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(51): col: 4 Error: Ambiguous reference to errorDisplay.
			errorDisplay("X Location: " + this.x);
			^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(52): col: 4 Error: Ambiguous reference to errorDisplay.
			errorDisplay("Y Location: " + this.y);
			^
C:\_io\interacti\games\The-Ledge\development\src\The-Ledge\Engine\TriggerEvent.as(53): col: 4 Error: Ambiguous reference to errorDisplay.
			errorDisplay("--------------------------------");
			^
