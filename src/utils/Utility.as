package utils
{
	public class Utility
	{
		public function Utility()
		{
			super();
		}
		
		public static function randNum(min:Number, max:Number):Number
		{
			return Math.floor((Math.random() * max) + min);
		}
	}
}